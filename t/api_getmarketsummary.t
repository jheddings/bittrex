#!/usr/bin/perl

use strict;
use warnings;

use Bittrex;
use Test::Simple tests => 2;

my $bittrex = Bittrex->new();

#-------------------------------------------------------------------------------

ok($bittrex->getmarketsummary('BTC-LTC'));
ok(! $bittrex->getmarketsummary('-'));

