#!/usr/bin/env perl

use strict;
use Data::Dumper;
use List::MoreUtils qw(uniq);

my $sum = 0;

# input lines are like this:
# Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53

while(<>){
  m/Card\s+\d+: (.*?) \| (.*)/ or die 'Bad line: ', $_;

  my $winning_numbers = extract_numbers($1);
  my $drawn_numbers = extract_numbers($2);

  my $count = match_count($winning_numbers, $drawn_numbers);
  my $score = score_for($count);
 
  $sum += $score;
}

print "Total score: $sum\n";

sub extract_numbers {
  my @num_list = (@_[0] =~ m/\d+/g);
  return \@num_list;
}

sub match_count {
  my($a, $b) = @_;
  scalar @$a + scalar @$b - scalar uniq(@$a, @$b);
}

sub score_for {
  my $n = shift;
  return 2**($n-1) if $n > 0;
  return 0;
}
