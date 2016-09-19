#!/usr/bin/env perl
use strict;
use warnings;
use KZ;

# display json replies or not
$KZ::verbose = 1;

my $auth = login "admin", "admin", "admin";

make_std_account($auth, "cc1.kazoo", "1");
make_std_account($auth, "cc2.kazoo", "2");

sub make_std_account {
	my ($auth, $domain, $index) = @_;
	my $acc = make_account token $auth, $domain;

	my $u1 = make_user token $auth, id $acc, 1, $domain;
	my $u2 = make_user token $auth, id $acc, 2, $domain;
	my $u3 = make_user token $auth, id $acc, 3, $domain;

	my $d1 = make_device token $auth, id $acc, id $u1, 1;
	my $d2 = make_device token $auth, id $acc, id $u2, 2;
	my $d3 = make_device token $auth, id $acc, id $u2, 3;

	my $cf1 = make_callflow_user token $auth, id $acc, id $u1, "1001";
	my $cf2 = make_callflow_user token $auth, id $acc, id $u2, "1002";
	my $cf3 = make_callflow_user token $auth, id $acc, id $u2, "1003";

	my $conf1 = make_conference token $auth, id $acc, id $u1, 1;
	my $cf4 = make_callflow_conference token $auth, id $acc, id $conf1, "2001";

	my $n1 = add_spare_number token $auth, id $acc, "+1415777${index}001";
	my $n2 = add_spare_number token $auth, id $acc, "+1415777${index}002";
}
