#!/usr/bin/perl

use strict;
use warnings;

use Bittrex::API;
use Test::Simple tests => 2;

my $bittrex = Bittrex::API->new();

#-------------------------------------------------------------------------------

ok($bittrex->getmarketsummary('BTC-LTC'));
ok(! $bittrex->getmarketsummary('-'));

