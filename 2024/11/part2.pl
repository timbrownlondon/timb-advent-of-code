#!/usr/bin/env perl

use strict;
use lib '.';
use FasterStones;

my $S = FasterStones->new_from_string(join '', <>);

for my $i (1..75){
  $S->next();
  print "$i\t", ,$S->count_stones(), "\n";
}
