package Bittrex;

=encoding utf8

=head1 NAME

Bittrex - modules for interacting with the L<Bittrex|https://www.bittrex.com> exchange.

=head1 SYNOPSIS

  use Bittrex::API;

  my $bittrex = Bittrex::API->new();
  my $market_data = $bittrex->getmarkets();

=cut

use strict;
use warnings;

our $VERSION = '1.0';

=head1 DESCRIPTION

TODO

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
