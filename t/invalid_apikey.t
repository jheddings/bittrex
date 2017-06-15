#!/usr/bin/perl

use strict;
use warnings;

use Bittrex::API;
use Test::Simple tests => 9;

# simple tests to make sure bad keys don't work

#---------------------------------------
# no key or secret provided
my $bittrex = Bittrex::API->new();
ok(! $bittrex->getbalances());
ok(! $bittrex->getbalance('LTC'));

#---------------------------------------
# a key provided, but no secret
$bittrex = Bittrex::API->new('no_key', undef);
ok(! $bittrex->getbalances());
ok(! $bittrex->getbalance('ETH'));

#---------------------------------------
# a secret provided, but no key
$bittrex = Bittrex::API->new(undef, 'no_secret');
ok(! $bittrex->getbalances());
ok(! $bittrex->getbalance('DASH'));

#---------------------------------------
# bogus key & secret
$bittrex = Bittrex::API->new('no_key', 'no_secret');
ok(! $bittrex->getbalances());
ok(! $bittrex->getbalance('BTC'));
ok(! $bittrex->getbalance('*'));

