#!/usr/bin/perl

use strict;
use warnings;

use Test::Simple tests => 12;

use Bittrex;

my $bittrex = Bittrex->new();

#-------------------------------------------------------------------------------
## basic API calls

ok($bittrex->getmarkets());
ok($bittrex->getmarketsummaries());
ok($bittrex->getcurrencies());

#-------------------------------------------------------------------------------
## getticker

ok($bittrex->getticker('BTC-ETH'));
#ok(! $bittrex->getticker());
ok(! $bittrex->getticker('-ETH'));

#-------------------------------------------------------------------------------
## getmarketsummary

ok($bittrex->getmarketsummary('BTC-LTC'));
ok(! $bittrex->getmarketsummary('-'));

#-------------------------------------------------------------------------------
## getmarkethistory

ok($bittrex->getmarkethistory('BTC-LTC'));
ok(! $bittrex->getmarkethistory('NADA-NONE'));

#-------------------------------------------------------------------------------
## getorderbook

ok($bittrex->getorderbook('BTC-LTC', 'both', 20));
ok($bittrex->getorderbook('BTC-ETH', 'buy'));
ok($bittrex->getorderbook('BTC-DASH', 'sell', 50));

