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

my $bittrex_auth = Bittrex->new($key, $secret);
my $bittrex_no_secret = Bittrex->new($key, undef);
my $bittrex_no_key = Bittrex->new(undef, $secret);

#-------------------------------------------------------------------------------

ok($bittrex_auth->getbalances());

ok(! $bittrex_no_key->getbalances());
ok(! $bittrex_no_secret->getbalances());

