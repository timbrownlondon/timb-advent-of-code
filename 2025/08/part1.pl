#!/usr/bin/env perl 

use lib '.';
use Data::Dumper;
use Circuits;
use strict;

my $C = Circuits->new(<>);

for my $i (0..999){
  $C->step($i);
}

my $GS = $C->group_sizes();

print Dumper $GS;

print $GS->[0] * $GS->[1] * $GS->[2], "\n";
