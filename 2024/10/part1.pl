#!/usr/bin/env perl

use strict;
use lib '.';
use Trail;
use Data::Dumper;

my $T = Trail->new_from_string(join '', <>);

$T->find_paths();

print $T->count_nines(), "\n";
