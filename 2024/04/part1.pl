#!/usr/bin/env perl

use strict;
use Data::Dumper;

sub main{
  my @lines = <>;
  my $total = 0;

print count_matches('XMAS', \@lines), "\n";
print count_matches('SAMX', \@lines), "\n";

  $total += count_matches('XMAS', \@lines);
  $total += count_matches('SAMX', \@lines);

  my $rotated = rotate_lines(\@lines);
print count_matches('XMAS', $rotated), "\n";
print count_matches('SAMX', $rotated), "\n";
  $total += count_matches('XMAS', $rotated);
  $total += count_matches('SAMX', $rotated);

  print "Total: $total\n";
}

sub count_matches{
  my $match_string = shift;
  my $lines = shift;

  my $count = 0;
  for my $l (@$lines){
    my @found = ($l =~ m/$match_string/g);
    $count += scalar @found;
  }
  return $count; 
}

sub rotate_lines{
  my $array = shift;

  my $matrix;
  for my $line (@$array){
    my @chars = split //, $line;
    push @$matrix, \@chars;
  }
  my $width = scalar @$array;
  my $height = length $$array[0];

  my $rotated;
  for my $x (0..$width-1){
    for my $y (0..$height-1){
      $rotated->[$y][$x] = $matrix->[$x][$y];
    }
  }

  my @output;
  for my $col (@$rotated){
    push @output, join '', @$col;
  }

  return \@output;
}

sub tests{
  require Test::More;
  import Test::More tests => 3;

  is(count_matches('TIM',['_TIM_TIM','___TIM__']), 3, 'count_matches() OK');
  {
    my $lines = ['abcde','fghij','klmno','pqrst','uvwxy'];
    my $expected = ['afkpu','bglqv','chmrw','dinsx','ejoty'];
    is_deeply(rotate_lines($lines), $expected, 'rotate_lines() 5x5 - OK');
  }
  {
    my $lines = ['abc','def','ghi','jkl'];
    my $expected = ['adgj','behk','cfil'];
    is_deeply(rotate_lines($lines), $expected, 'rotate_lines() 4x3 - OK');
  }
}

# choose to run main() or tests()
($ARGV[0] =~ m/test/)? tests() : main();
