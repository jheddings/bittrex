package Bittrex;

our $VERSION = '1.0';

# this is a placeholder for the top level module and project documentation

=encoding utf8

=head1 NAME

Bittrex - modules and utilities for interacting with the
L<Bittrex|https://www.bittrex.com> exchange.

=head1 SYNOPSIS

This project consists of the C<Bittrex::API> module:

  use Bittrex::API;

  my $bittrex = Bittrex::API->new();
  my $market_data = $bittrex->getmarkets();

There is also a utility for interacting with the exchange from the command line:

  bittrex.pl --keyfile=apikey.cfg --getbalances

=head1 DESCRIPTION

Bittrex is a leading cryptocurrency exchange for buying & selling digital
currency. This software assumes no risk and makes no guarantees of performance
on any trades. Any examples provided here are for reference only and do not
imply any recommendations for investment strategies.

Full API documentation can be found here:
L<https://bittrex.com/Home/Api|https://bittrex.com/Home/Api>.

=head1 REQUIREMENTS

=over

=item B<URI::Query> - to build proper query strings for requests

=item B<Config::Simple> - used to read configuration files

=back

=head1 INSTALLATION

To install using the default options and location, use the following commands:

  perl Makefile.PL
  make
  make install

See L<ExtUtils::MakeMaker}http://perldoc.perl.org/ExtUtils/MakeMaker.html> for customizing
the installation.  Parameters may be optionally passed to C<Makefile.PL> to alter the
behavior.  The most common parameter to set is C<INSTALL_BASE> which sets the top of the
installation target.

For example, to change the base installation path, use the following:

  perl Makefile.PL INSTALL_BASE=/usr/local

Tests are included with the module, however they require a valid API key in order to
succeed.  Eventually, I hope to mock out the API so they can run without direct access
to the API service.  If that happens, or you just want to try it out, use the following:

  make test

=head1 AUTHOR

Developed and maintained by L<jheddings|https://github.com/jheddings>.

Tips are always appreciated!

=over

=item BTC - C<1K6mkumfqTQTF4HJuLZAh1g8uRHQhWLomz>

=item ETH - C<0xA114CE80Fc995a993d5726a74DAf08ad8C739Af4>

=item DASH - C<XmTsc9qQQctrauq8zVXXoL9c8DKd29q2Gd>

=item LTC - C<LLscXRCUndQRjQdbTouvDE9NH5fiaanZzo>

=back

=head1 COPYRIGHT

Copyright (c) 2017 Jason Heddings

Licensed under the terms of the L<MIT License|https://opensource.org/licenses/MIT>,
which is also included in the original L<source code|https://github.com/jheddings/bittrex>
of this project.

=cut
