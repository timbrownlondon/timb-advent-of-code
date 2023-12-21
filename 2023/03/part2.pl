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
    print scalar @gears, " stars on row $row\n";

    for (@gears){
        my $found_at = index($line, '*', $offset);
        print "row: $row, star found at $found_at with offset of $offset\n";
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
    
    if ($row > 0){
        $star->{number_at}->{1} = extract_number_at($row -1, $col -1) if $char[$row -1][$col -1] =~ m/\d/;
        $star->{number_at}->{3} = extract_number_at($row -1, $col +1) if $char[$row -1][$col +1] =~ m/\d/;
    }
    if ($col > 0){
        $star->{number_at}->{4} = extract_number_at($row,    $col -1) if $char[$row   ][$col -1] =~ m/\d/;
    }
    if ($col < 139){
        $star->{number_at}->{6} = extract_number_at($row,    $col +1) if $char[$row   ][$col +1] =~ m/\d/;
    }
    if ($row < 139){
        $star->{number_at}->{7} = extract_number_at($row +1, $col -1) if $char[$row +1][$col -1] =~ m/\d/;
        $star->{number_at}->{9} = extract_number_at($row +1, $col +1) if $char[$row +1][$col +1] =~ m/\d/;
    }

    # it is possible that starting at 1 and 3 we have found the same number
    # if so then remove 3
    delete $star->{number_at}->{3} if $star->{number_at}->{1} eq $star->{number_at}->{3};
    # same for positions 7 and 9
    delete $star->{number_at}->{9} if $star->{number_at}->{7} eq $star->{number_at}->{9};
    print Dumper $star;
}

my $sum = 0;

for my $star (@stars){
    my $numbers = $star->{number_at};
    my @values = values %$numbers;
    my $count = scalar keys %$numbers;
    $sum += @values[0] * @values[1] if $count == 2;
    print $star->{row}, ',',$star->{col}, ": ($count) ",@values[0], ' x ', @values[1], ' = ',  @values[0] * @values[1]," subtotal: $sum\n";
}

print "Total score: $sum\n";

# print Dumper \@stars;
# print scalar @stars, "\n";

sub extract_number_at {
    my($row, $col) = @_;

    print "($row, $col) ", $char[$row][$col], "\n";

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
