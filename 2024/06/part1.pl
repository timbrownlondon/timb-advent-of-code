#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use Map;

my $lines = join '', <>;
my $MAP = Map->new_from_string($lines);

$MAP->move_until_fall_off_grid();
$MAP->show();

print $MAP->count_visited_cells(), "\n";
