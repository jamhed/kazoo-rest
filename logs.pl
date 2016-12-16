#!/usr/bin/env perl
use strict;
use warnings;
use KZ;
use POSIX qw(strftime);

$KZ::verbose = 0;
my $auth = login();

sub ft ($) {
	strftime("%m-%d %H:%M:%S", gmtime(shift));
}

sub get_next_page {
	my ($page, $size) = @_;
	return unless $page->{next_start_key};
	print "start: ", ft $page->{next_start_key}, " ",  $page->{next_start_key}, "\n";
	my $page1 = notifications token $auth, account_id $auth->{data}, $page->{next_start_key}, $size;
	data($page1);
	get_next_page($page1, $size);
}

my $size = 10;
my $page1 = notifications token $auth, account_id $auth->{data}, "", $size; #, 63641448952+13*24*3600, 5;
data($page1);
get_next_page($page1, $size);

sub data {
	my ($page) = @_;
	print scalar(@{$page->{data}}), ":\n";
	print join "\n", map { join " ", ft $_->{created}, $_->{created} } grep { ref($_) } @{$page->{data}};
	print "\n";
}


