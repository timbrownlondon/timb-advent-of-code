#!/usr/bin/env perl

use strict;

sub main{
  my $total = 0;
  while(<>){
    my @values = m/(\d+)/g or die "cannot parse line $_";
    $total++ if is_safe(@values);
  }
  print "Total: $total\n";
}

sub is_safe{
  my @values = @_;

  return are_differences_good(get_differences(@values));
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
  my @values = @_;
  my @result;

  for my $i (0..@values-2){
    push @result, $values[$i+1] - $values[$i];
  }
  return \@result;
}

# choose to run main(0 or tests()
($ARGV[0] =~ m/test/)? tests() : main();


sub tests{
  require Test::More;
  import Test::More tests => 18;

  is_deeply(get_differences(qw|1 2 4 7 9|), [1, 2, 3, 2], 'get_differences()');
  is_deeply(get_differences(qw|10 2 1 1 9|), [-8, -1, 0, 8], 'get_differences()');
  is_deeply(get_differences(qw|87 90 93 94 98|), [3,3,1,4], 'get_differences()');

  ok(are_differences_good([1,1,1]), 'are_differences_good() all positive');
  ok(are_differences_good([-1,-1,-1]), 'are_differences_good() all negative');
  ok(! are_differences_good([1,0,1]), 'are_differences_good() has a zero within positives');
  ok(! are_differences_good([-1,0,-1,-2]), 'are_differences_good() has a zero within negatives');
  ok(! are_differences_good([0,1,3,2,1]), 'are_differences_good() zero at start');
  ok(! are_differences_good([1,3,2,4,1]), 'are_differences_good() has value greater than 3');
  ok(! are_differences_good([-1,-3,-2,-4,-1]), 'are_differences_good() has value less than -3');
  ok(! are_differences_good([3,3,2,4]), 'are_differences_good() has value greater than 3');

  ok(is_safe(qw|27 29 30 33 34 35 37|), 'safe increasing');
  ok(is_safe(qw|80 78 77 75 74 73 71 70|), 'safe decreasing');
  ok(! is_safe(qw|51 53 54 55 57 60 63 63|), 'not safe, 63 follows 63');
  ok(! is_safe(qw|87 90 93 94 98|), 'not safe, 94 to 98 is too large jump');
  ok(! is_safe(qw|41 42 45 47 49 51 53 58|), 'not safe, 53 to 58 is too large jump');
  ok(! is_safe(qw|23 26 23 24 27 28|), 'not safe, going up then down');
  ok(! is_safe(qw|32 33 36 37 34 36 39 37|), 'not safe, going up then down');
}
