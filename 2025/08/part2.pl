#!/usr/bin/env perl 

use lib '.';
use Data::Dumper;
use Circuits;
use strict;

my $C = Circuits->new(<>);

my $i = 0;
while ($C->max_group_size() < 1000){
  print $C->step($i++), ' : ', $C->max_group_size(),"\n";
}

# last op is...
# point 624 added to group 581 (connect with point 136) : 1000
print Dumper $C->group_sizes();

print $C->{points}->[624]->x() * $C->{points}->[136]->x(), "\n";

