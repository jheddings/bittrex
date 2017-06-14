#!/usr/bin/perl

use strict;
use warnings;

use Bittrex;
use Test::Simple tests => 5;

my $bittrex = Bittrex->new();

#-------------------------------------------------------------------------------

ok($bittrex->getticker('BTC-ETH'));

ok(! $bittrex->getticker());
ok(! $bittrex->getticker('-ETH'));
ok(! $bittrex->getticker(''));
ok(! $bittrex->getticker('&&'));

