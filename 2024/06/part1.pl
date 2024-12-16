#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use Map;

my @lines = join '', <>;
my $MAP = Map->new_from_string(\@lines);

print Dumper $MAP;

