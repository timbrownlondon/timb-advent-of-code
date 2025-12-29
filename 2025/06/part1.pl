#!/usr/bin/env perl 

use lib '.';
use Data::Dumper;
use Cmath;
use strict;

my $C = Cmath->new(<>);

print $C->column_value(0), "\n";
print $C->column_value(1), "\n";
print $C->column_value(2), "\n";
print $C->column_value(3), "\n";
print $C->column_value(4), "\n";
print $C->column_value(999), "\n";
print $C->column_value(1000), "\n";

print $C->total_value(), "\n";
