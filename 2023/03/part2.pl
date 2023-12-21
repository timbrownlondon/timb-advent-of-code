#!/usr/bin/env perl

use strict;
use Data::Dumper;

my @char;
my @stars;
my $row = 0;

# populate 2D @char array
# populate @stars array with locations of star characters (aka gears)
while(<>){
	chomp;
    my $line = $_;
    my @line_array = split '', $line;  
    push @char, \@line_array;

    my $offset = 0;
    my @gears = m/\*/g;

    for (@gears){
        my $found_at = index($line, '*', $offset);
        $offset = $found_at + 1;

        push @stars, {row => $row, col => $found_at};
    }
    $row++;
}	
    

for my $star (@stars){
    # is there a number adjacent to this star?
    # lets use phone keypad to indicate position, ie.
    # 1 2 3
    # 4 * 6
    # 7 8 9
    # NB - we don't have to start searching from position 2 nor from 8
    my $row = $star->{row};
    my $col = $star->{col};
    
    $star->{at}->{1} = $char[$row -1][$col -1] =~ m/\d/;
    $star->{at}->{2} = $char[$row -1][$col   ] =~ m/\d/;
    $star->{at}->{3} = $char[$row -1][$col +1] =~ m/\d/;
    $star->{at}->{4} = $char[$row   ][$col -1] =~ m/\d/;
    $star->{at}->{6} = $char[$row   ][$col +1] =~ m/\d/;
    $star->{at}->{7} = $char[$row +1][$col -1] =~ m/\d/;
    $star->{at}->{8} = $char[$row +1][$col   ] =~ m/\d/;
    $star->{at}->{9} = $char[$row +1][$col +1] =~ m/\d/;


    if ($row > 0){
        $star->{number_at}->{1} = extract_number_at($row -1, $col -1) if $star->{at}->{1};
        $star->{number_at}->{2} = extract_number_at($row -1, $col)    if $star->{at}->{2} and ! $star->{at}->{1};
        $star->{number_at}->{3} = extract_number_at($row -1, $col +1) if $star->{at}->{3} and ! $star->{at}->{2};
    }
    if ($col > 0){
        $star->{number_at}->{4} = extract_number_at($row, $col -1) if $star->{at}->{4};
    }
    if ($col < 139){
        $star->{number_at}->{6} = extract_number_at($row, $col +1) if $star->{at}->{6};
    }
    if ($row < 139){
        $star->{number_at}->{7} = extract_number_at($row +1, $col -1) if $star->{at}->{7};
        $star->{number_at}->{8} = extract_number_at($row +1, $col)    if $star->{at}->{8} and ! $star->{at}->{7};
        $star->{number_at}->{9} = extract_number_at($row +1, $col +1) if $star->{at}->{9} and ! $star->{at}->{8};
    }
}

my $sum = 0;

for my $star (@stars){
    my $numbers = $star->{number_at};
    my @values = values %$numbers;
    my $count = scalar keys %$numbers;
    $sum += @values[0] * @values[1] if $count == 2;
}

print "Total score: $sum\n";

sub extract_number_at {
    my($row, $col) = @_;

    my $num_str = '';

    # look towards the right (increase col)
    my $i = $col;
    while ($char[$row][$i] =~ m/\d/){
        $num_str .= $char[$row][$i];
        $i++;
    }
    # look towards the left (decrease col)
    my $i = $col-1;
    while ($char[$row][$i] =~ m/\d/){
        $num_str = $char[$row][$i] . $num_str;
        $i--;
    }
    return $num_str;
}
