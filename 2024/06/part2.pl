#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use Map;

my $lines = join '', <>;
my $MAP = Map->new_from_string($lines);


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

$MAP->move_until_fall_off_grid();
$MAP->show();

print $MAP->count_visited_cells(), "\n";
