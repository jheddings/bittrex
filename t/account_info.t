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
  plan tests => 10;
} else {
  plan skip_all => 'apikey not found';
}

my $bittrex_auth = Bittrex->new($key, $secret);
my $bittrex_no_secret = Bittrex->new($key, undef);
my $bittrex_no_key = Bittrex->new(undef, $secret);

#-------------------------------------------------------------------------------
## basic account calls

ok($bittrex_auth->getbalances());
ok($bittrex_auth->getbalance('BTC'));
ok($bittrex_auth->getbalance('ETH'));
ok($bittrex_auth->getbalance('DASH'));

ok(! $bittrex_auth->getbalance());
ok(! $bittrex_auth->getbalance('*'));

## check how things go with bad credentials...

ok(! $bittrex_no_key->getbalances());
ok(! $bittrex_no_key->getbalance('BTC'));

ok(! $bittrex_no_secret->getbalances());
ok(! $bittrex_no_secret->getbalance('ETH'));
