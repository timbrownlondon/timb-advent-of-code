#!/usr/bin/env perl
use strict;
use Data::Dumper;

use lib '.';
use Ingredients;

my $I = Ingredients->new(<>);
  $I->print_range_items();
  print "___________________\n";

$I->repeat_reduction();
$I->print_range_items();
print 'Count ranges: ', $I->count_ranges(), "\n";
print 'Count range items ', $I->count_range_items(), "\n";
