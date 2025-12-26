#!/usr/bin/env perl
use strict;
use Data::Dumper;

use lib '.';
use Ingredients;

my $I = Ingredients->new(<>);

# print Dumper $I;
my $count = 0;

for my $id (@{$I->ids()}){
  $count++ if $I->is_fresh($id);
}

print "Count: $count\n";

