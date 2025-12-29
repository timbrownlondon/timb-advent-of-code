use Test::More; 
use lib '.';
use Data::Dumper;
use_ok Ingredients;
use strict;


open my $IN, '<', 'test-input' or die $!;
my $I= Ingredients->new(<$IN>);
close $IN;

isa_ok($I, 'Ingredients');

is_deeply($I->ranges(), ['3-5','10-14','16-20','12-18'], 'ranges() ok');
is(scalar @{$I->ranges()}, 4, 'ranges has 4 items');
is_deeply($I->ids(), ['1','5','8','11','17','32'], 'ids() ok');

is($I->is_fresh(1), 0, '0 is spoiled');
is($I->is_fresh(3), 1, '3 is fresh');
is($I->is_fresh(20), 1, '20 is fresh');

is($I->count_range_items(), 20, 'count_range_items() is 20');
is($I->repeat_reduction(), 0, 'repeat_reduction() returns 0');
is($I->count_range_items(), 14, 'count_range_items() is now 14');

done_testing();
