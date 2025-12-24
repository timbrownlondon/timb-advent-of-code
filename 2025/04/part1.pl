#!/usr/bin/env perl
use strict;
use Data::Dumper;

use lib '.';
use Rolls;

my $R = Rolls->new(<>);

# print Dumper $R;
my $count = 0;

for my $x (0 .. $R->row_count() -1){
  for my $y (0 .. $R->col_count() -1){
    # forklift can access a roll (@) if it has less than 4 occupied neighbours
    $count++ if $R->occupied_neighbour_count($x,$y) < 4 and $R->at($x,$y) eq '@';
  }
}

print "Count: $count\n";

