#!/usr/bin/perl -w

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'Bittrex',
    VERSION_FROM => 'lib/Bittrex.pm',

    EXE_FILES => [ 'bin/bittrex.pl' ],

    CONFIGURE_REQUIRES => {
      "ExtUtils::MakeMaker" => 0
    },

    BUILD_REQUIRES => {
      "ExtUtils::MakeMaker" => 0
    },

    TEST_REQUIRES => {
    },

    PREREQ_PM => {
      'JSON' => 2.94,
      'LWP::UserAgent' => 6.25,
      'LWP::Protocol::https' => 6.04,
      'URI::Query' => 0.10,
      'Digest::SHA' => 5.95,
      'Config::Simple' => 4.0
    },
);
