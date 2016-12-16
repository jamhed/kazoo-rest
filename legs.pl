#!/usr/bin/env perl
use strict;
use warnings;
use KZ;

$KZ::verbose = 1;
my $auth = login();

get_cdr_legs token $auth, account_id $auth->{data}, "201609-666bbdd0-b467-4a71-ae74-751d78c58f62";

