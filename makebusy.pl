#!/usr/bin/env perl
use strict;
use warnings;
use KZ;

my $auth = login();
my $re = makebusy token $auth, account_id $auth->{data};
print $re->content;
