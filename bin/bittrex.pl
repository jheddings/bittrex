#!/usr/bin/perl -w

=encoding utf8

=head1 NAME

bittrex.pl - command line wrapper for tradding on the L<Bittrex|https://www.bittrex.com> exchange.

=head1 SYNOPSIS

  bittrex.pl [--keyfile=file | --apikey=key --secret=secret] [options]

=cut

use strict;
use warnings;

use Getopt::Long qw( :config bundling );
use Scalar::Util qw( looks_like_number );
use Pod::Usage;

use Bittrex;
use Config::Simple;
use Data::Dumper;

=head1 OPTIONS

=head2 Key / Secret

=over

=item B<--keyfile=file> : Load API key and secret from the specified file

=item B<--apikey=str> : Specify the user's API key

=item B<--secret=str> : Provide the secret for API authentication

=back

=head2 Public Methods

=item B<--getmarkets> : get the open and available trading markets at Bittrex

=item B<--getcurrencies> : get all supported currencies at Bittrex

=item B<--getmarketsummaries> : get the last 24 hour summary of all active exchanges

=item B<--getticker=mkt> : get the current ticker values for a market (e.g. BTC-LTC)

=item B<--getmarketsummary=mkt> : get the last 24 hour summary for a market (e.g. BTC-LTC)

=item B<--getopenorders=mkt> : get open orders for a given market or all markets if C<mkt> is omitted

=back

=head2 Account Methods

=item B<--getbalances> : get all account balances

=item B<--getbalance=cur> : get account balances for the given currency (e.g. ETH)

=over

=back

=head2 Market Methods

=over

=item B<--buy=mkt> : place a buy order for the specified market,
requires C<--quantity>

=item B<--sell=mkt> : place a sell order for the specified market,
if C<--quantity> is not given, all shares will be sold

=item B<--cancel=id> : cancel the trade order with the given ID

=item B<--quantity=val> : specify the number of shares for an order

=item B<--rate=val> : limit the buy or sell request to the given rate

=back

=cut

################################################################################
# parse command line options
my $opt_help = 0;

my $keyfile = undef;
my $apikey = undef;
my $secret = undef;

my $do_getmarkets = undef;
my $do_getcurrencies = undef;
my $do_getmarketsummaries = undef;
my $do_getmarketsummary = undef;
my $do_getticker = undef;

my $do_getbalances = undef;
my $do_getbalance = undef;

my $do_buy = undef;
my $do_sell = undef;
my $do_cancel = undef;
my $do_getopenorders = undef;

my $opt_quantity = undef;
my $opt_rate = undef;

GetOptions(
  'keyfile=s' => \$keyfile,
  'apikey=s' => \$apikey,
  'secret=s' => \$secret,
  'getmarkets' => \$do_getmarkets,
  'getcurrencies' => \$do_getcurrencies,
  'getmarketsummaries' => \$do_getmarketsummaries,
  'getmarketsummary=s' => \$do_getmarketsummary,
  'getticker=s' => \$do_getticker,
  'getbalances' => \$do_getbalances,
  'getbalance=s' => \$do_getbalance,
  'getopenorders:s' => \$do_getopenorders,
  'buy=s' => \$do_buy,
  'sell=s' => \$do_sell,
  'cancel=s' => \$do_cancel,
  'quantity=f' => \$opt_quantity,
  'rate=f' => \$opt_rate,
  'help|?' => \$opt_help
) or usage(1);

usage(0) if $opt_help;

usage('Must provide keyfile or apikey') unless ((defined $keyfile) or (defined $apikey));
usage('Provide either keyfile or apikey (but not both)') if ((defined $keyfile) and (defined $apikey));
usage('Must provide secret for apikey') if ((not defined $secret) and (defined $apikey));
usage("Key file not found: $keyfile") if ((defined $keyfile) && (not -f $keyfile));

usage('Cannot buy & sell at the same time') if ((defined $do_buy) and (defined $do_sell));
usage('Must provide quantity for buy orders') if ((defined $do_buy) and (not defined $opt_quantity));
usage('Must provide quantity for sell orders') if ((defined $do_sell) and (not defined $opt_quantity));

################################################################################
# a convenience method for displaying usage information & exit with an error by default
sub usage {
  my $message = shift;
  my $exitval = 1;

  if (looks_like_number($message)) {
    $exitval = $message;
    $message = undef;
  }

  pod2usage( -message => $message, -exitval => $exitval );

  # pod2usage should take care of this, but just in case...
  exit $exitval;
}

################################################################################
sub load_keyfile {
  my $keyfile = shift;

  # TODO better error handling if the file cannot be parsed or params are missing

  my $cfg = new Config::Simple($keyfile);
  my $key = $cfg->param('key');
  my $secret = $cfg->param('secret');

  return ($key, $secret);
}

################################################################################
sub print_market_summary {
  my $data = shift;

  print $data->{MarketName};

  printf(" %f %f %f", $data->{High}, $data->{Low}, $data->{Volume});
  printf(" %f %f %f", $data->{Bid}, $data->{Ask}, $data->{Last});

  print"\n";
}

################################################################################
## MAIN ENTRY

if (defined $keyfile) {
  ($apikey, $secret) = load_keyfile($keyfile);
}

# common client instance
my $bittrex = Bittrex->new($apikey, $secret);

#---------------------------------------
if (defined $do_getmarkets) {
  my $data = $bittrex->getmarkets();
  if ($data) {
    foreach (@{ $data }) {
      printf("%s : %sActive\n", $_->{MarketName}, ($_->{IsActive} ? '' : 'Not '));
    }
  } else {
    printf("No market data available\n");
  }
}

#---------------------------------------
if (defined $do_getmarketsummaries) {
  my $data = $bittrex->getmarketsummaries();
  if ($data) {
    foreach (@{ $data }) {
      print_market_summary($_);
    }
  } else {
    printf("No market data available\n");
  }
}

#---------------------------------------
if (defined $do_getcurrencies) {
  my $data = $bittrex->getcurrencies();
  if ($data) {
    foreach (@{ $data }) {
      printf("%s [%s] : %sActive\n", $_->{CurrencyLong}, $_->{Currency},
             ($_->{IsActive} ? '' : 'Not '));
    }
  } else {
    printf("No currency data available\n");
  }
}

#---------------------------------------
if (defined $do_getticker) {
  my $data = $bittrex->getticker($do_getticker);
  if ($data) {
      my $bid = $data->{Bid};
      my $ask = $data->{Ask};
      my $last = $data->{Last};
      my $spread = ($ask - $bid) / $ask;

      printf("%f / %f (%.4f%%) : %f\n", $bid, $ask, 100*$spread, $last)

  } else {
    printf("Ticker data unavailable for %s\n", $do_getticker);
  }
}

#---------------------------------------
if (defined $do_getmarketsummary) {
  my $data = $bittrex->getmarketsummary($do_getmarketsummary);
  if ($data) {
    print_market_summary($data);
  } else {
    printf("No market data available for: $do_getmarketsummary\n");
  }
}

#---------------------------------------
if (defined $do_buy) {
  unless (defined $opt_rate) {
    my $data = $bittrex->getticker($do_buy);
    $opt_rate = $data->{Ask};
  }

  printf("Placing BUY order for %f %s @ %f\n", $opt_quantity, $do_buy, $opt_rate);
  my $id = $bittrex->buylimit($do_buy, $opt_quantity, $opt_rate);

  if ($id) {
    printf("Buy order placed: %s\n", $id);
  } else {
    printf("Buy order failed\n");
  }
}

#---------------------------------------
if (defined $do_sell) {
  unless (defined $opt_rate) {
    my $data = $bittrex->getticker($do_sell);
    $opt_rate = $data->{Bid};
  }

  printf("Placing SELL order for %f %s @ %f\n", $opt_quantity, $do_sell, $opt_rate);
  my $id = $bittrex->selllimit($do_sell, $opt_quantity, $opt_rate);

  if ($id) {
    printf("Order placed: %s\n", $id);
  } else {
    printf("Order failed\n");
  }
}

#---------------------------------------
if (defined $do_cancel) {
  my $ret = $bittrex->cancel($do_cancel);

  if ($ret) {
    printf("Order canceled: %s\n", $do_cancel);
  } else {
    printf("Could not cancel order: %s\n", $do_cancel);
  }
}

#---------------------------------------
if (defined $do_getopenorders) {
  my $data = $bittrex->getopenorders($do_getopenorders);
  if ($data and (scalar @{ $data})) {
    foreach (@{ $data }) {
      #TODO display quantity remaining
      #TODO how to use Price vs Limit ?
      printf("%s: %s %f @ %f - %s\n", $_->{Exchange}, $_->{OrderType},
             $_->{Quantity}, $_->{Limit}, $_->{OrderUuid});
    }
  } else {
    printf("No open orders\n");
  }
}

#---------------------------------------
if (defined $do_getbalances) {
  my $data = $bittrex->getbalances();
  if ($data) {
    foreach (@{ $data }) {
      if ($_->{Balance} gt 0.0) {
        printf("%s: %f [%f]\n", $_->{Currency}, $_->{Balance}, $_->{Available});
      }
    }
  } else {
    printf("No currency data available\n");
  }
}

#---------------------------------------
if (defined $do_getbalance) {
  my $data = $bittrex->getbalance($do_getbalance);
  if ($data) {
    printf("%s: %f [%f]\n", $data->{Currency}, $data->{Balance}, $data->{Available});
  } else {
    printf("No currency data available\n");
  }
}

