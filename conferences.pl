#!/usr/bin/env perl
use strict;
use warnings;
use KZ;
use JSON;

$KZ::verbose = 1;
my $auth = login();