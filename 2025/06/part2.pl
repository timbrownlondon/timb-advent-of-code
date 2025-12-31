#!/usr/bin/env perl 

use lib '.';
use Data::Dumper;
use Cmath;
use strict;

my $C = Cmath->new(<>);

print $C->total_part2(), "\n";
