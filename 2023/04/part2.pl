#!/usr/bin/env perl

use strict;
use Data::Dumper;
use List::MoreUtils qw(uniq);

my $cards;

# input lines are like this:
# Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53

# extract all data into a hash
while(<>){
  m/Card\s+(\d+): (.*?) \| (.*)/ or die 'Bad line: ', $_;

  my $card = {'card_number' => $1};

  $card->{winning_numbers} = extract_numbers($2);
  $card->{drawn_numbers}   = extract_numbers($3);

  $card->{score} = count_matches($card->{winning_numbers}, $card->{drawn_numbers});
  $cards->{$1} = $card;
}

my $instances;

for my $card_number (sort { $a <=> $b } keys %$cards){
    $instances->{$card_number}++; # count this card
    print "Processing card: $card_number with ", $instances->{$card_number}, " instances\n";

    for my $i (1 .. $instances->{$card_number}){
        print "    Instance $i of card $card_number\n";
        print '    Iterating ', $cards->{$card_number}->{score}, " times\n";
        for my $n (1 .. $cards->{$card_number}->{score}){
            $instances->{$card_number + $n}++;
            print '      There are now ', $instances->{$card_number + $n}," instances of ", $card_number+$n,"\n";
        }
    }
}

my $sum = 0;
for my $card_number (keys %$instances){
    $sum += $instances->{$card_number};
}
print "Total number of cards: $sum\n";

sub extract_numbers {
  my @num_list = (@_[0] =~ m/\d+/g);
  return \@num_list;
}

sub count_matches {
  my($a, $b) = @_;
  scalar @$a + scalar @$b - scalar uniq(@$a, @$b);
}

sub score_for {
  my $n = shift;
  return 2**($n-1) if $n > 0;
  return 0;
}
