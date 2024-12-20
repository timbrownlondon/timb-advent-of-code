use Test::More tests => 14;
use lib '.';
use Data::Dumper;
use_ok Map;
use strict;

my $grid = <<ENDSTR;
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
ENDSTR

my $MAP = Map->new_from_string($grid);
$MAP->show();

is($MAP->width(), 10, 'width() is 10');
is($MAP->height(), 10, 'height() is 10');
is($MAP->start_y_position(), 6, 'start_y_position() is 6');
is($MAP->start_x_position(), 4, 'start_x_position() is 4');
is($MAP->y_direction(), -1, 'y_direction() is -1');
is($MAP->x_direction(), 0, 'x_direction() is 0');
ok($MAP->position_is_on_grid(), 'position_is_on_grid()');

ok($MAP->move_one_place(), 'move_one_place()');
is($MAP->y_position(), 5, 'y_position() is 5');
is($MAP->x_position(), 4, 'x_position() is 4');

is($MAP->move_until_fall_off_grid(), 44, 'move_until_fall_off_grid() returns number of moves');
is($MAP->count_visited_cells(), 41, 'count_visited_cells() returns 41');

is_deeply($MAP->cells_with_char('#'), [[4,0],[9,1],[2,3],[7,4],[1,6],[8,7],[0,8],[6,9]], 'cells_with_char()');

$MAP->show();