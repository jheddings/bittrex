#!/usr/bin/perl

use strict;
use warnings;

use Bittrex;
use FindBin;
use Test::More;

#-------------------------------------------------------------------------------
# load the user's custom API key and secret
use Bittrex::Keyfile;
my ($key, $secret) = Bittrex::Keyfile::load();

if (defined $key and defined $secret) {
  plan tests => 5;
} else {
  plan skip_all => 'apikey not found';
}

my $bittrex = Bittrex->new($key, $secret);

#-------------------------------------------------------------------------------

my $btc_addr = $bittrex->getdepositaddress('BTC');

ok(defined $btc_addr);
ok($btc_addr ne -1);

# some basic negative testing...

ok(! $bittrex->getdepositaddress('*'));
ok(! $bittrex->getdepositaddress());

# remove API key...
$bittrex = Bittrex->new();
ok(! $bittrex->getdepositaddress('BTC'));
