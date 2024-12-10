#!/usr/bin/env perl

use strict;
my @col1;
my @col2;
my $col2_count;

sub main{
  # populate arrays
  while(<>){
    m/(\d+)\s+(\d+)/ or die "expecting 2 integers, but read $_";
    push @col1, $1;
    $col2_count->{$2}++
  }

  my $total = 0;
  for my $val (@col1){
    next unless $col2_count->{$val};
    $total += $val * $col2_count->{$val};
  }
  print "Total: $total\n";
}

main();
