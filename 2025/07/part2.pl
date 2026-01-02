#!/usr/bin/env perl 

use lib '.';
use Data::Dumper;
use Manifold;
use strict;

my $M = Manifold->new(<>);

my $memo = {};
my $num_paths = $M->count_paths(0, $M->S_column(), $memo);
print "Count paths $num_paths\n";

