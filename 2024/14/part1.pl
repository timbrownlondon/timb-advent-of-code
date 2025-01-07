#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use Robots;

my $lines = join '', <>;
my $R = Robots->new_from_string(101, 103, $lines);

$R->move_for_100_seconds();

print $R->safety_factor(), "\n";
