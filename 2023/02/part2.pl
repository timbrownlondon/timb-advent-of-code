#!/usr/bin/env perl

use strict;
use Data::Dumper;

my $sum = 0;

while(my  $line = <>){
    my $game_data = extract_data_from_line($line);

    $sum += power_value_of($game_data);
}

print "Grand total: $sum\n";


sub extract_data_from_line {
    my $line = shift;

    # lines like this...
    # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green

    $line =~ m/Game (\d+): (.*)/;
    my $data = {game_number => $1 + 0};

    my @grabs;
    for my $grab_string ( split ';', $2 ){
        for my $cube_set (split ',', $grab_string){
            push @grabs, $cube_set;
        }
    }
    $data->{cubes} = \@grabs;
    return $data;
}

sub power_value_of {
    my $data = shift;
    # the power value is the product of max red cubes x max green cubes x max blue cubes

    my $max_count = {
        red => 0,
	green => 0,
	blue => 0
    };

    for my $cube_set (@{$data->{cubes}}){
	$cube_set =~ m/(\d+) (\w+)/ or die $cube_set;
        my $count = $1 + 0;	
        my $colour = $2;	
	$max_count->{$colour} = $count if $count > $max_count->{$colour};
    }
    return $max_count->{red} * $max_count->{green} * $max_count->{blue};
}
