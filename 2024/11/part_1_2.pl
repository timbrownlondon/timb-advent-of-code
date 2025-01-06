#!/usr/bin/env perl

use strict;
use lib '.';
use Stones;

my $S = Stones->new_from_string(join '', <>);

for my $i (1..25){
  $S->next_string();
}

print $S->count_stones(), "\n";
