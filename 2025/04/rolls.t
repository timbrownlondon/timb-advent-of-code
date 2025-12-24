use Test::More; 
use lib '.';
use Data::Dumper;
use_ok Rolls;
use strict;

#################
#
my $map = <<'END';
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
END

my $R= Rolls->new(split /\n/, $map);
isa_ok( $R, 'Rolls' );

# warn Dumper $R;

is($R->row_count(), 10, 'has 10 rows');
is($R->col_count(), 10, 'has 10 cols');

is($R->at(0,0), '.', 'item at(0,0) is .');
is($R->at(1,1), '@', 'item at(1,1) is @');
is($R->at(9,9), '.', 'item at(9,9) is .');
is($R->at(3,3), '@', 'item at(3,3) is @');
is($R->at(10,10), '', "item at(10,10) is ''");
is($R->at(99,-99), '', "item at(99,-99) is ''");
is($R->at(-1,-1), '', "item at(-1,-1) is ''");

is($R->neighbours(1,1), '..@@@@@@', 'neighbours(1,1) is ..@@@@@@');
is($R->occupied_neighbour_count(1,1), 6, 'occupied_neighbour_point(1,1) is 6');

#################

my $R2 = Rolls->new(qw(123 456 789));

is($R2->row_count(), 3, 'has 3 rows');
is($R2->col_count(), 3, 'has 3 cols');

is($R2->at(0,0), '1', 'item at(0,0) is 1');
is($R2->at(1,0), '2', 'item at(1,0) is 2');
is($R2->at(2,0), '3', 'item at(2,0) is 3');
is($R2->at(0,1), '4', 'item at(0,1) is 4');
is($R2->at(2,1), '6', 'item at(2,1) is 6');
is($R2->at(0,2), '7', 'item at(0,2) is 1');
is($R2->at(1,2), '8', 'item at(1,2) is 8');
is($R2->at(2,2), '9', 'item at(2,2) is 9');

is($R2->neighbours(1,1), '12346789', '>neighbours(1,1) is 12346789');

# warn Dumper $R2;

done_testing();
