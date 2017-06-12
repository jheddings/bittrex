#!/usr/bin/perl

use strict;
use warnings;

use Bittrex;
use Test::Simple tests => 14;

my $bittrex = Bittrex->new();

#-------------------------------------------------------------------------------
## basic API calls

ok($bittrex->getmarkets());
ok($bittrex->getmarketsummaries());
ok($bittrex->getcurrencies());

#-------------------------------------------------------------------------------
## getticker (with some negative tests)

ok($bittrex->getticker('BTC-ETH'));
ok(! $bittrex->getticker());
ok(! $bittrex->getticker('-ETH'));

#-------------------------------------------------------------------------------
## getmarketsummary (with some negative tests)

ok($bittrex->getmarketsummary('BTC-LTC'));
ok(! $bittrex->getmarketsummary('-'));

#-------------------------------------------------------------------------------
## getmarkethistory (with some negative tests)

ok($bittrex->getmarkethistory('BTC-DASH'));
ok(! $bittrex->getmarkethistory(''));
ok(! $bittrex->getmarkethistory('NADA-NONE'));

#-------------------------------------------------------------------------------
## getorderbook (with some negative tests)

ok($bittrex->getorderbook('BTC-LTC', 'both', 20));
ok($bittrex->getorderbook('BTC-ETH', 'buy'));
ok($bittrex->getorderbook('BTC-DASH', 'sell', 50));

