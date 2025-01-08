#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use Robots;

open my $F, '<', 'input';
my $lines = join '', <$F>;
close $F;

my $R = Robots->new_from_string(101, 103, $lines);

my $i = 0;

while ( $i < 1000 ){
  $R->show();
  print "------- $i";
  # my $user = <STDIN>;
  $R->move();
  $i++;
}
