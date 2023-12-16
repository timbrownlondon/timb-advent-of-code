#!/usr/bin/env perl

use strict;
use Data::Dumper;

my @char;
my @stars_at;
my $row = 0;

# populate 2D @char array
# populate @stars array with locations of star characters (aka gears)
while(<>){
    print;
	chomp;
    my $line = $_;
    my @line_array = split '', $line;  
    push @char, \@line_array;

    my $offset = 0;
    my @gears = m/\*/g;
    print scalar @gears, " stars on row $row\n";

    for (@gears){
        my $found_at = index($line, '*', $offset);
        print "row: $row, star found at $found_at with offset of $offset\n";
        $offset = $found_at + 1;

        push @stars_at, {row => $row, col => $found_at};
    }
    $row++;
}	
    
my $sum = 0;

for my $location (@stars_at){
    # is there a number near by
    # lets use phone keypad to indicate position, ie.
    # 1 2 3
    # 4 * 6
    # 7 8 9
    #
    my @number_at;
    push (@number_at, 1) if $char[$location->{row} - 1][$location->{col} - 1] =~ m/\d/;
    push (@number_at, 2) if $char[$location->{row} - 1][$location->{col}    ] =~ m/\d/;
    push (@number_at, 3) if $char[$location->{row} - 1][$location->{col} + 1] =~ m/\d/;
    push (@number_at, 4) if $char[$location->{row}    ][$location->{col} - 1] =~ m/\d/;
    push (@number_at, 6) if $char[$location->{row}    ][$location->{col} + 1] =~ m/\d/;
    push (@number_at, 7) if $char[$location->{row} + 1][$location->{col} - 1] =~ m/\d/;
    push (@number_at, 8) if $char[$location->{row} + 1][$location->{col}    ] =~ m/\d/;
    push (@number_at, 9) if $char[$location->{row} + 1][$location->{col} + 1] =~ m/\d/;

    $location->{number_at} = \@number_at;
    
    if (@number_at > 2){
        print Dumper $location;
        die
    }

}

print "Total score: $sum\n";

print Dumper \@stars_at;

