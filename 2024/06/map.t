use Test::More tests => 8;
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

is($MAP->width(), 10, 'width() is 10');
is($MAP->height(), 10, 'height() is 10');
is($MAP->start_y_position(), 6, 'start_y_position() is 6');
is($MAP->start_x_position(), 4, 'start_x_position() is 4');
is($MAP->y_direction(), -1, 'y_direction() is -1');
is($MAP->x_direction(), 0, 'x_direction() is 0');
ok($MAP->move_one_place(), 'move_one_place()');

$MAP->show();

# print Dumper $MAP;
# print Dumper $MAP->grid();
