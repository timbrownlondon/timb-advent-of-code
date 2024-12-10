#!/usr/bin/env perl

use strict;
use Data::Dumper;
my $position;
my $highest;
my @col1;
my @col2;

sub main{
  # populate data structures
  while(<>){
    m/(\d+)\s+(\d+)/ or die "expecting 2 integers, but read $_";
    push @col1, $1;
    push @col2, $2;
  }

  print 'Total: ', sum_differences(build_data_for(\@col1), max_value_of(\@col1), build_data_for(\@col2), max_value_of(\@col2)), "\n";
}

sub sum_differences {
  my ($column_1_data, $column_1_max, $column_2_data, $column_2_max) = @_;

  my $total = 0;
  my $data_length = scalar keys %$column_1_data;
  my $col1_pointer = 0;
  my $col2_pointer = 0;
  
  # iterate over data to sum the result
  for my $j (1..$data_length){
    my $position_of_next_from_col1 = find_next_position($column_1_data, $column_1_max);
    my $position_of_next_from_col2 = find_next_position($column_2_data, $column_2_max);

    print "Col 1: $position_of_next_from_col1 ",
          "Col 2: $position_of_next_from_col2 ",
          "Diff: ", abs($position_of_next_from_col1 - $position_of_next_from_col2), "\n";
    $total += abs($position_of_next_from_col1 - $position_of_next_from_col2);
  }

  return $total;
}

sub max_value_of{
  my $array = shift;
  my @sorted = sort {$b <=> $a} @$array;
  return $sorted[0];
}

sub build_data_for {
  my $integers = shift;
  my $data;
  my $i = 0;

  for my $value (@$integers){
    $i++;
    $data->{$i}->{value} = $value;
  }
  return $data;
}

sub find_next_position{
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
  die "data is exhausted\n" unless $position_of_lowest;

  return $position_of_lowest;
}

# tests can be run like...
# ./part1.pl test
# otherwise main() is invoked
($ARGV[0] =~ m/test/)? tests() : main();

sub tests{
  require Test::More;
  import Test::More tests => 12;
  use Test::Exception;

  my @integers = (20, 9, 2, 18, 7);

  my $data = build_data_for(\@integers);
  is($data->{1}->{value}, 20, 'data built correctly');
  is($data->{2}->{value}, 9,  'data built correctly');
  is($data->{3}->{value}, 2,  'data built correctly');
  is($data->{4}->{value}, 18, 'data built correctly');
  is($data->{5}->{value}, 7,  'data built correctly');

  is(max_value_of($data), 20, 'max_value_for');

  is(find_next_position($data, 20), 3, '1st call returns 3');
  is(find_next_position($data, 20), 5, '2nd call returns 5');
  is(find_next_position($data, 20), 2, '3rd call returns 2');
  is(find_next_position($data, 20), 4, '4th call returns 4');
  is(find_next_position($data, 20), 1, '5th call returns 1');
  dies_ok {find_next_position($data, 20)} '6th call dies';

  
}
