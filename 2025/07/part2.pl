#!/usr/bin/env perl 

use lib '.';
use Data::Dumper;
use Manifold;
use strict;

my $M = Manifold->new(<>);

my $tracks = [];

$M->timelines(0,$M->S_column(),'', $tracks);

print 'Timeslines: ', scalar @$tracks, "\n";

# my $dedupe;
# for my $t (@$tracks){
# next if $dedupe->{$t};
# $dedupe->{$t}++;
# print "$t\n";
# }
