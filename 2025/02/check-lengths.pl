#!/usr/bin/env perl

use strict;

my $data = <>;
chomp $data;

for my $range (split /,/, $data){
  die "Bad data: $range\n" unless $range =~ m/(\d+)-(\d+)/;
  print length "$1", ",$1\n";
  print length "$2", ",$2\n";
}

# the largest number has ten digits

