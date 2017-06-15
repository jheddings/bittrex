#!/usr/bin/perl

use strict;
use warnings;

use Bittrex::API;
use Test::Simple tests => 8;

my $bittrex = Bittrex::API->new();

#-------------------------------------------------------------------------------

my $data = $bittrex->getticker('BTC-ETH');
ok(defined $data);

ok(exists $data->{Bid});
ok(exists $data->{Ask});
ok(exists $data->{Last});

# some basic negative testing...

ok(! $bittrex->getticker());
ok(! $bittrex->getticker('-ETH'));
ok(! $bittrex->getticker(''));
ok(! $bittrex->getticker('&&'));

