#!/usr/bin/env perl

use strict;
use Data::Dumper;
use List::MoreUtils qw(uniq);

my @numbers;
my @symbols;
my $total_rows = 0;
my $line_length = 0;

while(<>){
    print;
    chomp;
    my $line = $_;
    $line_length = length($line);

    my @digit_strings = $line =~ /\d+/g;
    
    # add each digit_string to @numbers along with its position row, col
    my $offset =0;
    for my $n (@digit_strings){
        my $obj->{value} = $n;
        $obj->{row} = $total_rows;
        $obj->{col} = index($line, $n, $offset);
        $obj->{line} = $line;
        push @numbers, $obj;

        $offset = $obj->{col} + length($n);
    }

    my @line_array = split '', $line;  
    push @symbols, \@line_array;

    $total_rows++;
}    
    
my $sum = 0;
for my $n (@numbers){
    my $include_this_number = has_adjacent_symbol($n);

    if ($include_this_number){
        $sum += $n->{value};
        print $n->{value}, " add\n";
    }
    else {
        print $n->{value}, "\n";
    }
}
print "Total score: $sum\n";

sub has_adjacent_symbol {
    my $n = shift;

    my $col_min = $n->{col};
    $col_min-- if $col_min > 0;

    my $col_max = $n->{col}+length($n->{value});
    $col_max-- if $col_max == $line_length;

    my $row_min = $n->{row};
    $row_min-- if $row_min > 0;

    my $row_max = $n->{row};
    $row_max++ if $row_max < $total_rows - 1;

    for my $c ($col_min .. $col_max){
        for my $r ($row_min .. $row_max){
           my $found = index('#$%&*-+=@/', $symbols[$r][$c]);
           return 1 if $found > -1;
       }
    }
    return 0;
}
