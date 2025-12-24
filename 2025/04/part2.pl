#!/usr/bin/env perl
use strict;
use Data::Dumper;

use lib '.';
use Rolls;

my $R = Rolls->new(<>);

# print Dumper $R;
my $count = 0;

my $map_is_changing = 1;
while ($map_is_changing){
  $map_is_changing = 0;

  for my $x (0 .. $R->row_count() -1){
    for my $y (0 .. $R->col_count() -1){
      # forklift can access a roll (@) if it has less than 4 occupied neighbours
      if($R->occupied_neighbour_count($x,$y) < 4 and $R->at($x,$y) eq '@'){
        $count++;
        $map_is_changing = 1;
        $R->remove_roll_at($x,$y);
      }
    }
  }
  print "Count: $count\n";
}

print "Count: $count\n";

