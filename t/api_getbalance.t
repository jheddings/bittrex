#!/usr/bin/perl

use strict;
use warnings;

use Bittrex;
use FindBin;
use Test::More;

#-------------------------------------------------------------------------------
# load the user's custom API key and secret
require("$FindBin::Bin/apikey.pl");
my ($key, $secret) = APIKEY::load();

unless (defined $key and defined $secret) {
  plan skip_all => 'apikey not found';
}

my $bittrex = Bittrex->new($key, $secret);

#-------------------------------------------------------------------------------
sub verify_balance {
  my ($cur, $bal) = @_;

  my $data = $bittrex->getbalance($cur);

  ok($data->{Currency} eq $cur);
  ok($data->{Balance} eq $bal);
}

#-------------------------------------------------------------------------------
## confirm all balances match

my $balances = $bittrex->getbalances();

ok($balances);
ok(scalar @{ $balances } gt 0);

foreach (@{ $balances }) {
  verify_balance($_->{Currency}, $_->{Balance});
}

#-------------------------------------------------------------------------------
## do some negative testing

ok(! $bittrex->getbalance());
ok(! $bittrex->getbalance('%'));

# remove API key...
$bittrex = Bittrex->new();

ok(! $bittrex->getbalance('BTC'));

done_testing();
