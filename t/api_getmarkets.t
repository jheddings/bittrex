#!/usr/bin/perl

use strict;
use warnings;

use Bittrex;
use Test::Simple tests => 1;

my $bittrex = Bittrex->new();

#-------------------------------------------------------------------------------

ok($bittrex->getmarkets());

