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

is_deeply($C->closest_points(), [0,19], 'closest_points OK');


# warn Dumper $C->ordered_pairs();
# warn Dumper $C->closest_points();

# for my $d (@{$C->ordered_pairs()}){
# warn $d->{dist}, ' ', $d->{i}, ' ', $d->{j},"\n";
# }

# warn Dumper $C->point(0);
# warn Dumper $C->point(19);

done_testing();
