use Test::More tests => 7;
use lib '.';
use Data::Dumper;
use_ok Farm;
use strict;

my $STR = <<END;
RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE
END

my $F = Farm->new_from_string($STR);
isa_ok( $F, 'Farm' );

is( $F->crop(3,4), 'R', 'crop(3,4) is R' );
is( $F->crop(4,10), 'I', 'crop(4,10) is I' );

is( $F->fences_for_cell(3,4), 3, 'fences_for_cell(3,4) is 3' );
is( $F->fences_for_cell(4,10), 3, 'fences_for_cell(4,10) is 3' );
is( $F->fences_for_cell(10,10), 2, 'fences_for_cell(10,10) is 2' );

# print Dumper $F->regions();


