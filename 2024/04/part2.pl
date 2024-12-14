#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use WordSearch;

my @lines = <>;
my $WS = WordSearch->new(\@lines);

my $total = $WS->count_X_MAS();

print "Total: $total\n";
