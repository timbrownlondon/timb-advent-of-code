#!/usr/bin/env perl

use strict;


my $count = 0;
my $position = 50;

while (<>){
  my ($direction, $clicks) = m/([L|R])(\d+)/ or die "Don't like line: $_";

  $clicks = -1 * $clicks if $direction eq 'L';
  $position = ($position + $clicks) % 100;

  print "$position $_";


  $count ++ unless $position; # count when dial is at zero
}

print "Count: $count\n";
