#!/usr/bin/env perl
use strict;
use warnings;
use KZ;
use POSIX qw(strftime);
use Furl;

our $furl = Furl->new(
	ssl_opts => {
		timeout => 60
	});

sub to_influx {
	my ($line) = @_;
	$furl->post("http://influx.jamhed.tk/write?db=cdr", [ 'Content-Type' => 'application/x-www-form-urlencoded'], $line);
}

sub FROM_GREG {
	return (shift()-GREG(0))*1000000000;
}

$KZ::verbose = 0;
my $auth = login();

sub paged {
	my ($created_from, $start_key) = @_;
	my @cdrs;
	my $w = cdrs_from token $auth, account_id $auth->{data}, $created_from, $start_key;
	push @cdrs, @{$w->{data}};
	if (my $next_key = $w->{next_start_key}) {
		push @cdrs, paged($created_from, $next_key);
	}
	return @cdrs;
}

my @cdrs = paged(GREG(time-12*24*3600));

foreach my $cdr (@cdrs) {
	print join " ", $cdr->{datetime}, $cdr->{duration_seconds}, "\n";
	to_influx sprintf("call,direction=%s,cause=%s,from=%s,to=%s duration=%s %s",
		$cdr->{direction},
		$cdr->{hangup_cause},
		$cdr->{calling_from},
		$cdr->{dialed_number},
		$cdr->{duration_seconds},
		FROM_GREG($cdr->{timestamp})
	);
}

__END__
{
	"caller_id_name" : "VTech Conf Phone",
	"rfc_1036" : "\"Wed, 14 Dec 2016 18:31:29 GMT\"",
	"direction" : "inbound",
	"call_priority" : "",
	"billing_seconds" : "0",
	"media_recordings" : [],
	"rate" : "0.0",
	"unix_timestamp" : "1481740289",
	"to" : "32@4a6863.sip.sandbox.2600hz.com:7000",
	"callee_id_name" : "",
	"rate_name" : "",
	"owner_id" : "",
	"iso_8601" : "\"2016-12-14\"",
	"callee_id_number" : "",
	"id" : "201612-1751791984",
	"calling_from" : "vtech",
	"timestamp" : "63648959489",
	"other_leg_call_id" : "",
	"dialed_number" : "32",
	"from" : "vtech@4a6863.sip.sandbox.2600hz.com",
	"recording_url" : "",
	"bridge_id" : "1751791984",
	"call_type" : "",
	"hangup_cause" : "ORIGINATOR_CANCEL",
	"duration_seconds" : "0",
	"request" : "32@4a6863.sip.sandbox.2600hz.com",
	"datetime" : "2016-12-14 18:31:29",
	"caller_id_number" : "vtech",
	"cost" : "0",
	"call_id" : "1751791984",
	"authorizing_id" : "852ccd50accbe6885164570dd6cd3c89"
}
