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

if (defined $key and defined $secret) {
  plan tests => 11;
} else {
  plan skip_all => 'apikey not found';
}

my $bittrex_auth = Bittrex->new($key, $secret);
my $bittrex_no_secret = Bittrex->new($key, undef);
my $bittrex_no_key = Bittrex->new(undef, $secret);

#-------------------------------------------------------------------------------
sub check_balance {
  my $cur = shift;

  my $bal = $bittrex_auth->getbalance($cur);
  ok($bal->{Currency} eq $cur);

  # perform some negative tests while we are here...
  ok(! $bittrex_no_key->getbalance($cur));
  ok(! $bittrex_no_secret->getbalance($cur));
}

#-------------------------------------------------------------------------------

check_balance('BTC');
check_balance('ETH');
check_balance('DASH');

ok(! $bittrex_auth->getbalance());
ok(! $bittrex_auth->getbalance('*'));

