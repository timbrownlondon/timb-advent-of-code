#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use PrintingSpec;;

my (@rules, @updates);

while (<>){
  chomp;
  last unless m/\d/;
  push @rules, $_;
}

while (<>){
  chomp;
  push @updates, $_;
}

my $PS = PrintingSpec->new(\@rules, \@updates);

print 'Total: ', $PS->sum_of_middle_element_of_valid_updates(), "\n";