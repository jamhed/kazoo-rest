#!/usr/bin/env perl
use strict;
use warnings;
use KZ;
use POSIX qw(strftime);

$KZ::verbose = 1;
my $auth = login();

my $w = cdrs token $auth, account_id $auth->{data};

foreach my $cdr (@$w) {
	print join " ", $cdr->{datetime}, $cdr->{duration_seconds}, "\n";
}
