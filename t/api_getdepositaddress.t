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
  plan tests => 3;
} else {
  plan skip_all => 'apikey not found';
}

my $bittrex = Bittrex->new($key, $secret);

#-------------------------------------------------------------------------------

ok($bittrex->getdepositaddress('BTC'));
ok(! $bittrex->getdepositaddress('*'));
ok(! $bittrex->getdepositaddress());
