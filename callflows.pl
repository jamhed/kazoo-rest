#!/usr/bin/env perl
use strict;
use warnings;
use KZ;
use JSON;

$KZ::verbose = 1;
my $auth = login 'user1@cc1.kazoo', 'user1pas', 'cc1.kazoo';

my $flows = get_callflows token $auth, account_id $auth->{data};
foreach (@$flows) {
	modify($_->{id}) if $_->{type} and $_->{type} eq 'conference';
}

sub modify {
	my ($id) = @_;
	my $cf = KZ::get_callflow token $auth, account_id $auth->{data}, $id;
	$cf->{flow}{data}{welcome_prompt}{play} = JSON::false;
	update_callflow token $auth, account_id $auth->{data}, $cf;
}
