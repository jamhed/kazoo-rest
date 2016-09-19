#!/usr/bin/env perl
use strict;
use warnings;
use KZ;

$KZ::verbose = 0;
my $auth = login 'user1@cc1.kazoo', 'user1pas', 'cc1.kazoo';

my $confs = get_conferences token $auth, account_id $auth->{data};
foreach my $conf (@$confs) {
	print $conf->{id}, " ", $conf->{name}, "\n";
}

