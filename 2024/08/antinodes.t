use Test::More tests => 14;
use lib '.';
use Data::Dumper;
use_ok Antinode;
use strict;

my $grid = <<ENDSTR;
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
ENDSTR

my $ANT = Antinode->new_from_string( $grid );

isa_ok( $ANT, 'Antinode' );
is($ANT->width(), 12, 'width() is 12' );
is($ANT->height(), 12, 'height() is 12' );

is_deeply($ANT->antenna_chars(), ['0','A'], 'antenna_chars() is [0,A]' );
is_deeply($ANT->antenna_points(), {'0'=>[[8,1],[5,2],[7,3],[4,4]],'A'=>[[6,5],[8,8],[9,9]] }, 'antenna_points() is {0=>[...' );

ok($ANT->is_on_grid([8,1]), 'is_on_grid([8,1] is true');
ok($ANT->is_on_grid([0,0]), 'is_on_grid([0,0] is true');
ok(! $ANT->is_on_grid([12,1]), 'is_on_grid([12,1] is false');
ok(! $ANT->is_on_grid([-1,6]), 'is_on_grid([-1,6] is false');

is_deeply($ANT->antinodes_for_pair([0,0],[3,2]), [[-3,-2],[6,4]], 'antinodes_for_pair([0,0],[3,2])');
is_deeply($ANT->antinodes_for_pair([0,4],[3,2]), [[-3,6],[6,0]], 'antinodes_for_pair([0,4],[3,2])');

is($ANT->antinode_count(), 14, 'antinode_count() is 14');

$ANT->include_harmonics(1);
is($ANT->antinode_count(), 34, 'antinode_count() is 34 with harmonics');

$ANT->show_antinodes();
