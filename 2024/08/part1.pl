#!/usr/bin/env perl

use strict;
use lib '.';
use Antinode;

my $lines = join '', <>;
my $ANT = Antinode->new_from_string($lines);

print $ANT->antinode_count(), "\n";

