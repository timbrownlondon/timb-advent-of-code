#!/usr/bin/env perl

use strict;
use Data::Dumper;

my $dial; # array of dial positions to count visits
my $position = 50;

while (<>){
  print "----\n";
  chomp;
  my ($direction, $clicks) = m/([L|R])(\d+)/ or die "Don't like line: $_";

  my $delta;
  $delta = -1 if $direction eq 'L';
  $delta = 1 if $direction eq 'R';
  print "DELTA $delta\n";

  for my $i (1 .. $clicks){
    # move dial one click
    $position += $delta;

    $position += 100 if $position < 0;
    $position -= 100 if $position > 99;
    $dial->[$position]++;
    print "$_\t$i\t$position\t", $dial->[$position], "\n";
  }
}

for my $i (0 .. 99){
  print $i, "\t", $dial->[$i], "\n";
}

print 'Zero has been visited ', $dial->[0], " times\n";

# 6534 is too low
# 7054 is too high
# 5962 is wrong
#  try 6591
