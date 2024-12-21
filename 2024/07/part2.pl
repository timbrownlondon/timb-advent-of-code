#!/usr/bin/env perl

use strict;
use Data::Dumper;
use lib '.';
use BridgeRepair;

my $lines = join '', <>;
my $BR = BridgeRepair->new_from_string(3, $lines);

print $BR->total(), "\n";

