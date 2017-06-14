#!/usr/bin/perl

use strict;
use warnings;

use Bittrex;
use Test::Simple tests => 5;

my $bittrex = Bittrex->new();

#-------------------------------------------------------------------------------

ok($bittrex->getmarkethistory('BTC-DASH'));

ok(! $bittrex->getmarkethistory());
ok(! $bittrex->getmarkethistory(''));
ok(! $bittrex->getmarkethistory('NADA-NONE'));
ok(! $bittrex->getmarkethistory('!'));

