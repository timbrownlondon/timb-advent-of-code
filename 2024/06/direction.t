use Test::More;
use Test::Exception tests => 12;
use lib '.';
use Data::Dumper;
use_ok Direction;
use strict;

  dies_ok {Direction->new('NORTH')} 'new(NORTH) dies';

  ok(my $d = Direction->new('left'), 'new(left)');
  is($d->char(), '←', 'char() is ←');

  is($d->turn_right(), '↑', 'rurn_right() returns ↑');
  is($d->x_move(), 0, 'x_move() returns 0');
  is($d->y_move(), -1, 'y_move() returns -1');


  is($d->turn_right(), '→', 'rurn_right() returns →');
  is($d->x_move(), 1, 'x_move() returns 1');
  is($d->y_move(), 0, 'y_move() returns 0');

  ok(! Direction->is_visited_char('o'), 'is_visited_char(o) is false');
  ok(  Direction->is_visited_char('↑'), 'is_visited_char(↑) is true');



