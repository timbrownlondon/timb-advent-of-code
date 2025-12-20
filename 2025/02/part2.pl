#!/usr/bin/env perl
use strict;

use lib '.';
use Valid;

my $V = Valid->new;

my $data = <>;
chomp $data;

my $sum = 0;

for my $range (split /,/, $data){
  die "Bad data: $range\n" unless $range =~ m/(\d+)-(\d+)/;
  print "$range\n"; 

  for my $i ($1 .. $2){
    print $i, '  ', $V->is_valid($i), "\n";
    $sum += $i unless  $V->is_valid($i);
  }
}

print "Sum: $sum\n";


