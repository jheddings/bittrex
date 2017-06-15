#!/usr/bin/perl

use strict;
use warnings;

use Bittrex::API;
use Test::Simple tests => 1;

my $bittrex = Bittrex::API->new();

#-------------------------------------------------------------------------------

ok($bittrex->getmarketsummaries());

