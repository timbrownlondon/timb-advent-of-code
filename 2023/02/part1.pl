#!/usr/bin/env perl

use strict;
use Data::Dumper;

my $sum = 0;

while(my  $line = <>){
    my $game_data = extract_data_from_line($line);

    print is_valid_game($game_data), ' ', $line;

    $sum += $game_data->{game_number} if is_valid_game($game_data); 
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

sub is_valid_game {
    my $data = shift;
    # the games is valid if  bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes

    for my $cube_set (@{$data->{cubes}}){
	$cube_set =~ m/(\d+) (\w+)/ or die $cube_set;
        my $count = $1 + 0;	
        my $colour = $2;	
	return 0 if $colour eq 'red' and $count > 12;
	return 0 if $colour eq 'green' and $count > 13;
	return 0 if $colour eq 'blue' and $count > 14;
    }
    return 1;
}
