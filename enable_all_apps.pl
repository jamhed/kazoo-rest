#!/usr/bin/env perl
use strict;
use warnings;
use KZ;

$KZ::verbose = 0;
my $auth = login "admin", "admin", "admin";

my $apps = get_apps token $auth, account_id $auth->{data};
foreach my $app (@$apps) {
	print name $app, " ", id $app, "\n";
	eval {
		enable_app_for_all token $auth, account_id $auth->{data}, id $app; 
	};
}
