use Test::More; 
use lib '.';
use Data::Dumper;
use_ok Circuits;
use strict;

open my $IN, '<', 'test-input' or die $!;
my $C = Circuits->new(<$IN>);
close $IN;

isa_ok($C, 'Circuits');

my $p1 = Point->new(0,0,0);
my $p2 = Point->new(0,0,0);
my $p3 = Point->new(1,2,3);

is($C->distance_squared($p1,$p2), 0, 'distance_squared($p1,$p2) is 0');
is($C->distance_squared($p1,$p3), 14, 'distance_squared($p1,$p3) is 14');

is_deeply($C->ordered_pairs()->[0], {i=>0,j=>19,dist=>100427}, 'ordered_pairs()->[0] OK');

is($C->step(0), 'points 0 and 19 added to new group 1', 'points 0 and 19 added to new group 1');
is($C->step(1), 'point 7 added to group 1', 'point 7 added to group 1');
is($C->step(2), 'points 2 and 13 added to new group 2', 'points 2 and 13 added to new group 2');
is($C->step(3), 'points 7 and 19 are already in same group 1', 'points 7 and 19 are already in same group 1');

$C->step(4);
$C->step(5);
$C->step(6);
$C->step(7);
$C->step(8);

is($C->step(9), 'points 2 and 18: groups 2 and 3 merged to be group 6', 'points 2 and 18: groups 2 and 3 merged to be group 6'); 

is_deeply($C->group_sizes(),[ 5, 4, 2, 2 ], 'group_sizes() ok');; 

done_testing();
