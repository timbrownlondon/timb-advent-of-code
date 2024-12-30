#!/usr/bin/env perl

use strict;
use lib '.';
use Diskfragmenter;
use Data::Dumper;

my $DF = Diskfragmenter->new_from_string(<>);

$DF->move_files_forward();

print $DF->checksum_part2(), "\n";
