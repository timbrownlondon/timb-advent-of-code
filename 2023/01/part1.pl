#!/usr/bin/env perl

use strict;

my $sum = 0;

while(my  $line = <>){
    my $number_for_this_line = process_line($line);
    print "$number_for_this_line $line";
    $sum += $number_for_this_line;
}

print "Grand total: $sum\n";


sub process_line {
    my $line = shift;

    my @chars = split '', $line;
    my $first_number = get_first_number(@chars);
    my $last_number = get_first_number(reverse @chars);

    return  10 * $first_number + $last_number;
}

sub get_first_number {
  for (@_){
      return $_ if m/\d/;
  }
}
