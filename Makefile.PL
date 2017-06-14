#!/usr/bin/perl -w

use 5.014;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'Bittrex',
    VERSION_FROM => 'lib/Bittrex.pm',

    PREREQ_PM => {
      'JSON' => 2.94,
      'LWP::UserAgent' => 6.25,
      'URI::Query' => 0.10,
      'Digest::SHA' => 5.95,
      'Config::Simple' => 4.0,
      'Exporter::Easy' => 0.17
    },
);

