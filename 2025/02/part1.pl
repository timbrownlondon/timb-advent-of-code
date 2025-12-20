#!/usr/bin/env perl

use strict;

my $data = <>;
chomp $data;

my $sum = 0;

for my $range (split /,/, $data){
  die "Bad data: $range\n" unless $range =~ m/(\d+)-(\d+)/;
  print "$range\n"; 

  for my $i ($1 .. $2){
    print $i, '  ', is_invalid($i), "\n";
    $sum += $i if is_invalid($i);
  }
}

print "Sum: $sum\n";

sub is_invalid {
  my $n = shift;
  my $len = length "$n";
  my $middle = int($len/2);
  #  print "$n $len\n";
  return 0 unless $middle * 2 == $len;

  my $first_half =  substr($n, 0, $middle), "\n";
  my $second_half =  substr($n, $middle, $len), "\n";
  return 1 if $first_half eq $second_half;
  return 0; 
}

