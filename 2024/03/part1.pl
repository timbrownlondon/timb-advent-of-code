#!/usr/bin/env perl

use strict;

my $text = join '', <>;
my @valid_functions = ($text =~ m/(mul\(\d+,\d+\))/gs);

my $total = 0;
for my $func (@valid_functions){
  $func =~ m/(\d+),(\d+)/;
  $total += $1 * $2;
}
print "Total: $total\n";
