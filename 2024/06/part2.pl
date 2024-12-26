#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use Map;

my $lines = join '', <>;
my $original = Map->new_from_string($lines);


# how do we detect new barriers that cause a loop?
# thoughts:
#  - new barriers are placed on cells from the route identified in Part 1
#  - so we can iterate through those cells
#  - and start a 'journey' from the original start point
#  - if after n moves we have not fallen off grid then we have found a valid
#  'loop barrier'
#
#  it would be good to have a more emphatic way of detecting a loop
#  something like...
#  if we have been at current cell before and headed in the same direction we
#  are on a loop
#  that means we need to store cell position and direction for each cell
#  visited
#
#  →
#  ←
#  ↑
#  ↓

$original->move_until_fall_off_grid();

# iterate along original route
# trying each point as a barrier
for my $point ( @{$original->route()} ){
  
  my $candidate = Map->new_from_string($lines);
  my ($x,$y, $ch) = @$point;

  $candidate->set_cell($x,$y,'O'); 

  while ( $candidate->move_one_place() ){
    if ( $candidate->is_loop() ){
      print "found loop for ($x, $y) ";
      my $loop_start = $candidate->is_loop();
      print 'loop start at ', $loop_start->[0], ', ', $loop_start->[1], ', ',$loop_start->[2];
      print ' route length: ', scalar @{$candidate->route()}, "\n";
      last;
    }
    unless ($candidate->position_is_on_grid() ){
      print "no loop for ($x, $y) last position (",$candidate->x_position(), ', ', $candidate->y_position(), ")\n"; 
      last;
    }
  }
}

