#!/usr/bin/env perl

use strict;

sub main{
  my $total = 0;
  while(<>){
    my @values = m/(\d+)/g or die "cannot parse line $_";
    $total++ if is_safe_with_tolerance(@values);
  }
  print "Total: $total\n";
}

# allow one number to be 'bad'
sub is_safe_with_tolerance{
  my @values = @_;

  for my $i(0..@values-1){
    return 1 if is_safe(array_with_item_omitted($i, @values));
  }
  return 0;
}

sub array_with_item_omitted{
  my $index = shift;
  my @items = @_;
  my @result;
  my $end_index = @items - 1;

  @result = @items[1..$end_index] if $index == 0;
  @result = @items[0..$end_index-1] if $index == $end_index;
  @result = (@items[0..$index-1], @items[$index+1..$end_index]);

  return \@result;
}



sub is_safe{
  my $values = shift;

  return are_differences_good(get_differences($values));
}

sub are_differences_good{
  my $diffs = shift;

  # all the elemenst of the array must be either poitive or all negative
  # none must be zero
  # none must be greater than 3 (absolute value)

  my $first = $$diffs[0];

  if($first > 0){
    for my $val (@$diffs){
       return 0 if $val < 1;
       return 0 if $val > 3;
    }
  }
  elsif($first < 0){
    for my $val (@$diffs){
      return 0 if $val > -1;
      return 0 if $val < -3;
    }
  }
  else {
    return 0;
  }
  return 1;
}

sub get_differences{
  my $values = shift;
  my @result;

  my $len = scalar @$values;
  for my $i (0..$len-2){
    push @result, $$values[$i+1] - $$values[$i];
  }
  return \@result;
}

# choose to run main(0 or tests()
($ARGV[0] =~ m/test/)? tests() : main();


sub tests{
  require Test::More;
  import Test::More tests => 24;

  is_deeply(get_differences([1, 2, 4, 7, 9]), [1, 2, 3, 2], 'get_differences()');
  is_deeply(get_differences([10, 2, 1, 1, 9]), [-8, -1, 0, 8], 'get_differences()');
  is_deeply(get_differences([87, 90, 93, 94, 98]), [3,3,1,4], 'get_differences()');

  ok(are_differences_good([1,1,1]), 'are_differences_good() all positive');
  ok(are_differences_good([-1,-1,-1]), 'are_differences_good() all negative');
  ok(! are_differences_good([1,0,1]), 'are_differences_good() has a zero within positives');
  ok(! are_differences_good([-1,0,-1,-2]), 'are_differences_good() has a zero within negatives');
  ok(! are_differences_good([0,1,3,2,1]), 'are_differences_good() zero at start');
  ok(! are_differences_good([1,3,2,4,1]), 'are_differences_good() has value greater than 3');
  ok(! are_differences_good([-1,-3,-2,-4,-1]), 'are_differences_good() has value less than -3');
  ok(! are_differences_good([3,3,2,4]), 'are_differences_good() has value greater than 3');

  ok(is_safe([27, 29, 30, 33, 34, 35, 37]), 'safe increasing');
  ok(is_safe([80, 78, 77, 75, 74, 73, 71, 70]), 'safe decreasing');
  ok(! is_safe([51, 53, 54, 55, 57, 60, 63, 63]), 'not safe, 63 follows 63');
  ok(! is_safe([87, 90, 93, 94, 98]), 'not safe, 94 to 98 is too large jump');
  ok(! is_safe([41, 42, 45, 47, 49, 51, 53, 58]), 'not safe, 53 to 58 is too large jump');
  ok(! is_safe([23, 26, 23, 24, 27, 28]), 'not safe, going up then down');
  ok(! is_safe([32, 33, 36, 37, 34, 36, 39, 37]), 'not safe, going up then down');

  # tests added for Part 2
  ok(is_safe_with_tolerance(qw|7 6 4 2 1|), 'Safe without removing any level.');
  ok(!is_safe_with_tolerance(qw|1 2 7 8 9|), 'Unsafe regardless of which level is removed.');
  ok(!is_safe_with_tolerance(qw|9 7 6 2 1|), 'Unsafe regardless of which level is removed.');
  ok(is_safe_with_tolerance(qw|1 3 2 4 5|), 'Safe by removing the second level, 3.');
  ok(is_safe_with_tolerance(qw|8 6 4 4 1|), 'Safe by removing the third level, 4.');
  ok(is_safe_with_tolerance(qw|1 3 6 7 9|), 'Safe without removing any level.');

  is_deeply(array_with_item_omitted(0,qw|1 2 3 4 5|),[2, 3, 4, 5], 'can remove index 0');
  is_deeply(array_with_item_omitted(1,qw|1 2 3 4 5|),[1, 3, 4, 5], 'can remove index 1');
  is_deeply(array_with_item_omitted(2,qw|1 2 3 4 5|),[1, 2, 4, 5], 'can remove index 2');
  is_deeply(array_with_item_omitted(3,qw|1 2 3 4 5|),[1, 2, 3, 5], 'can remove index 3');
  is_deeply(array_with_item_omitted(4,qw|1 2 3 4 5|),[1, 2, 3, 4], 'can remove index 4');
}
