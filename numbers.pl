#!/usr/bin/env perl
use strict;
use warnings;
use KZ;

$KZ::verbose = 1;
my $auth = login();

add_spare_number_with_cnam token $auth, account_id $auth->{data}, "+74157775016", "wef";
