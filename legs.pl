#!/usr/bin/env perl
use strict;
use warnings;
use KZ;

$KZ::verbose = 1;
my $auth = login 'user1@cc1.kazoo', 'user1pas', 'cc1.kazoo';

get_cdr_legs token $auth, account_id $auth->{data}, "201609-666bbdd0-b467-4a71-ae74-751d78c58f62";

