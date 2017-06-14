#!/usr/bin/perl -w

use 5.014;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'Bittrex',
    VERSION_FROM => 'lib/Bittrex.pm',

    PREREQ_PM => {
      'URI::Query' => 0.10,
      'Config::Simple' => 4.0,
      'Exporter::Easy' => 0.17
    },
);

