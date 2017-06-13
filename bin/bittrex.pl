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

=item B<--getticker=mkt> : get the current tick values for a market (e.g. BTC-LTC)

=over

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
my $do_getticker = undef;

GetOptions(
  'keyfile=s' => \$keyfile,
  'apikey=s' => \$apikey,
  'secret=s' => \$secret,
  'getmarkets' => \$do_getmarkets,
  'getcurrencies' => \$do_getcurrencies,
  'getticker=s' => \$do_getticker,
  'help|?' => \$opt_help
) or usage(1);

usage(0) if $opt_help;

usage('Must provide keyfile or apikey') unless ((defined $keyfile) or (defined $apikey));
usage('Provide either keyfile or apikey (but not both)') if ((defined $keyfile) and (defined $apikey));
usage('Must provide secret for apikey') if ((not defined $secret) and (defined $apikey));
usage("Key file not found: $keyfile") if ((defined $keyfile) && (not -f $keyfile));

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
## MAIN ENTRY

if (defined $keyfile) {
  ($apikey, $secret) = load_keyfile($keyfile);
}

# common client instance
my $bittrex = Bittrex->new($apikey, $secret);

#---------------------------------------
# /public/getmarkets
if ($do_getmarkets) {
  my $markets = $bittrex->getmarkets();
  if ($markets) {
    foreach (@{ $markets }) {
      printf("%s : %sActive\n", $_->{MarketName}, ($_->{IsActive} ? '' : 'Not '));
    }
  } else {
    printf("No market data available\n");
  }
}

#---------------------------------------
# /public/getcurrencies
if ($do_getcurrencies) {
  my $currencies = $bittrex->getcurrencies();
  if ($currencies) {
    foreach (@{ $currencies }) {
      printf("%s [%s] : %sActive\n", $_->{CurrencyLong}, $_->{Currency},
             ($_->{IsActive} ? '' : 'Not '));
    }
  } else {
    printf("No market data available\n");
  }
}

#---------------------------------------
# /public/getticker
if ($do_getticker) {
  my $ticker = $bittrex->getticker($do_getticker);
  if ($ticker) {
      my $bid = $ticker->{Bid};
      my $ask = $ticker->{Ask};
      my $last = $ticker->{Last};
      my $spread = ($ask - $bid) / $ask;

      printf("%f / %f (%.4f%%) : %f\n", $bid, $ask, 100*$spread, $last)

  } else {
    printf("Ticker data unavailable for %s\n", $do_getticker);
  }
}

