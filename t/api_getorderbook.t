#!/usr/bin/perl

use strict;
use warnings;

use Bittrex::API;
use Test::Simple tests => 3;

my $bittrex = Bittrex::API->new();

#-------------------------------------------------------------------------------

ok($bittrex->getorderbook('BTC-LTC', 'both', 20));
ok($bittrex->getorderbook('BTC-ETH', 'buy'));
ok($bittrex->getorderbook('BTC-DASH', 'sell', 50));

