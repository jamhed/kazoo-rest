#!/usr/bin/env perl
use strict;
use warnings;
use KZ;
use JSON;

$KZ::verbose = 1;
my $auth = login();

my $flows = get_dialplans token $auth, account_id $auth->{data};
