use Test::More tests => 3;
use lib '.';
use Data::Dumper;
use_ok Robots;
use strict;

my $STR = <<END;
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
p=2,0 v=2,-1
p=0,0 v=1,3
p=3,0 v=-2,-2
p=7,6 v=-1,-3
p=3,0 v=-1,-2
p=9,3 v=2,3
p=7,3 v=-1,2
p=2,4 v=2,-3
p=9,5 v=-3,-3
END

my $R = Robots->new_from_string(11,7,$STR);

isa_ok( $R, 'Robots' );

$R->move_for_100_seconds();

print Dumper $R;

$R->show_100_positions();

print Dumper $R->count_quadrants();

is( $R->safety_factor(), 12, 'safety_factor() is 12,' );
