#!/usr/bin/env perl

use strict;
use Data::Dumper;
my $i = 0;
my $position;
my $highest;

# populate data structures
while(<>){
  m/(\d+)\s+(\d+)/ or die "expecting 2 integers, but read $_";
  $i++;
  $position->{column_1}->{$i}->{value} = $1;
  $highest->{column_1} = $1 if $1 > $highest->{column_1};

  $position->{column_2}->{$i}->{value} = $2;
  $highest->{column_2} = $2 if $2 > $highest->{column_2};
}

my $total = 0;
my $col1_pointer = 0;
my $col2_pointer = 0;

for my $j (1..$i){
  my $position_of_next_from_col1 = find_next_position($position->{column_1}, $highest->{column_1});
  my $position_of_next_from_col2 = find_next_position($position->{column_2}, $highest->{column_2});

  #print "Col 1: $position_of_next_from_col1, Col 2: $position_of_next_from_col2 ", abs($position_of_next_from_col1 - $position_of_next_from_col2), "\n";
  $total += abs($position_of_next_from_col1 - $position_of_next_from_col2);
}
print "Total: $total\n";



sub find_next_position(){
  my ($column_data, $highest) = @_;

  my $position_of_lowest = 0;
  my $lowest_value = $highest;
  while (my ($key, $obj) = each(%$column_data)) {
    next if $obj->{ignore};
    # print "$key, $value\n";

    if( $obj->{value} <= $lowest_value ){
       $position_of_lowest = $key;
       $lowest_value = $obj->{value};
    }
  }

  $column_data->{$position_of_lowest}->{ignore} = 1;
  return $position_of_lowest;
}
