use Test::More tests => 19;
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
is($MAP->direction()->y_move(), -1, 'y_move() is -1');
is($MAP->direction()->x_move(), 0, 'x_move() is 0');
ok($MAP->position_is_on_grid(), 'position_is_on_grid()');

ok($MAP->move_one_place(), 'move_one_place()');
is($MAP->y_position(), 5, 'y_position() is 5');
is($MAP->x_position(), 4, 'x_position() is 4');

ok($MAP->move_one_place(), 'move_one_place()');
is_deeply($MAP->route(), [[4,6,'↑'],[4,5,'↑']], 'route() is [[4,6,↑],[4,5,↑]]');

is($MAP->move_until_fall_off_grid(), 45, 'move_until_fall_off_grid() returns number of moves');
is($MAP->count_visited_cells(), 41, 'count_visited_cells() returns 41');

is_deeply($MAP->cells_with_char('#'), [[4,0],[9,1],[2,3],[7,4],[1,6],[8,7],[0,8],[6,9]], 'cells_with_char()');

ok($MAP->add_to_route(0,1,'↑'), 'add_to_route(0,1,↑)');
ok($MAP->add_to_route(2,3,'↓'), 'add_to_route(2,3,↓)');

# print Dumper $MAP;
ok(! $MAP->is_loop(), 'is_loop() is false');

$MAP->show();
