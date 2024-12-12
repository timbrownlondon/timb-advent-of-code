#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use WordSearch;

my @lines = <>;
my $WS = WordSearch->new(\@lines);

my $total = 0;

$total += $WS->count_matches('XMAS');
$total += $WS->count_matches('SAMX');

$total += $WS->count_matches_on_rotated('XMAS');
$total += $WS->count_matches_on_rotated('SAMX');

print "Total: $total\n";
