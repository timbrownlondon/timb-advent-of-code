#!/usr/bin/env perl

use strict;
my @col1;
my @col2;

sub main{
  # populate arrays
  while(<>){
    m/(\d+)\s+(\d+)/ or die "expecting 2 integers, but read $_";
    push @col1, $1;
    push @col2, $2;
  }

  # make sorted copies of arraya
  my @sorted_1 = sort {$a <=> $b} @col1;
  my @sorted_2 = sort {$a <=> $b} @col2;

  my $total = 0;
  while(@sorted_1){
    $total += abs(pop(@sorted_1) - pop(@sorted_2));
  }
  print "Total: $total\n";
}

main();
