#!/usr/bin/env perl 

use lib '.';
use Data::Dumper;
use Manifold;
use strict;

my $M = Manifold->new(<>);

print $M->split_count(), "\n";
