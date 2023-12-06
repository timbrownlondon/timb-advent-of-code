#!/usr/bin/env perl

use strict;
use Data::Dumper;

my $value_of = {
    '1'     => 1,
    'one'   => 1,
    '2'     => 2,
    'two'   => 2,
    '3'     => 3,
    'three' => 3,
    '4'     => 4,
    'four'  => 4,
    '5'     => 5,
    'five'  => 5,
    '6'     => 6,
    'six'   => 6,
    '7'     => 7,
    'seven' => 7,
    '8'     => 8,
    'eight' => 8,
    '9'     => 9,
    'nine'  => 9
};

my $sum = 0;

while(my  $line = <>){
    my $number = number_for_this_line($line);
    print "$number $line";
    $sum += $number;
}

print "Grand total: $sum\n";

sub number_for_this_line {
    my $line = shift;

    my $extracted_digits = extract_digits($line);
    my @reversed_digits = reverse @$extracted_digits; 

    my $first_number = extract_first_number($extracted_digits);
    my $last_number  = extract_first_number(\@reversed_digits);

    return  10 * $first_number + $last_number;
}

sub extract_first_number {
    my $ordered_digits = shift;

    for my $d (@$ordered_digits){
        return $d if $d;
    }
    die 'failed to extract from ', @$ordered_digits;
}

sub extract_digits {
    my $line = shift;

    my @found_at;

    for my $digit (keys %$value_of){
        my $offset = 0;
        while ($offset < length $line) {
            my $position = index($line, $digit, $offset);
            last if $position < 0;
            $found_at[$position] = $value_of->{$digit};
            $offset++;
        }
    }
    return \@found_at;
}

