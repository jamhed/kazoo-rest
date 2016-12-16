#!/usr/bin/env perl
use strict;
use warnings;
use KZ;

$KZ::verbose = 1;
my $auth = login();

make_group_with_user($auth);
get_groups token $auth, account_id $auth->{data};

sub make_group_with_user {
	my ($auth) = @_;
	my $users = get_users token $auth, account_id $auth->{data};
	make_group token $auth, account_id $auth->{data}, $users->[0]->{id};
}
