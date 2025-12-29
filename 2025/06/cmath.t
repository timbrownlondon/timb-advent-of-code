use Test::More; 
use lib '.';
use Data::Dumper;
use_ok Cmath;
use strict;

open my $IN, '<', 'test-input' or die $!;
my $C= Cmath->new(<$IN>);
close $IN;

print Dumper $C;
isa_ok($C, 'Cmath');

is_deeply($C->get_column(0), [123,45,6,'*'], 'get_column_(0) OK');

is($C->column_value(0), 123 * 45 * 6, 'column_value(0) OK');

is($C->total_value(), 4277556, 'total_value() OK');

done_testing();
