use Test::More; 
use lib '.';
use Data::Dumper;
use_ok Cmath;
use strict;

open my $IN, '<', 'test-input' or die $!;
my $C= Cmath->new(<$IN>);
close $IN;

# warn Dumper $C;
isa_ok($C, 'Cmath');

# Part 1 functionality
is_deeply($C->get_column(0), [123,45,6,'*'], 'get_column_(0) OK');
is($C->column_value(0), 123 * 45 * 6, 'column_value(0) OK');
is($C->total_value(), 4277556, 'total_value() OK');

# Part 2 functionality
is($C->width(), 16, 'width() OK');
is($C->height(), 3, 'height() OK');
is_deeply($C->get_char_list(0), [1,' ',' ','*'], 'get_char_list(0) OK');
is_deeply($C->operator_row(), ['*',' ',' ',' ','+',' ',' ',' ','*',' ',' ',' ','+',' '], 'operator_row() OK');

my $slice = [[3,6,9,'+'],[2,4,8,' ' ],[8,' ',' ',' '],[' ',' ',' ',' ']];
is_deeply($C->get_matrix_data_at(4,7), $slice, 'get_matrix_data_at(4,7) OK');
is($C->eval_matrix_data($slice), 625, 'eval_matrix_data($slice) OK');

is_deeply($C->operator_indices(), [0,4,8,12,16], 'operator_indices() OK');
is($C->total_part2(), 3263827, 'total_part2() OK');

# warn Dumper $C->get_matrix_data_at(4,7);

done_testing();
