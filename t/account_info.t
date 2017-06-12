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
  plan tests => 6;
} else {
  plan skip_all => 'apikey not found';
}

my $bittrex_noauth = Bittrex->new();
my $bittrex_auth = Bittrex->new($key, $secret);

#-------------------------------------------------------------------------------
## basic account calls

ok($bittrex_auth->getbalances());
ok(! $bittrex_noauth->getbalances());

ok($bittrex_auth->getbalance('BTC'));
ok($bittrex_auth->getbalance('ETH'));
ok(! $bittrex_auth->getbalance());
ok(! $bittrex_auth->getbalance('*'));

