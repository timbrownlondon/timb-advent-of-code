#!/usr/bin/env perl
use strict;

use lib '.';
use Joltage;

my $J = Joltage->new;

my $sum = 0;
for my $number (<>){
  chomp $number;
  $sum += $J->jolt($number);
}

print "Sum: $sum\n";


