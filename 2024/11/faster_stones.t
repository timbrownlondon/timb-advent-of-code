use Test::More tests => 7;
use lib '.';
use Data::Dumper;
use_ok FasterStones;
use strict;

my $S = FasterStones->new_from_string('125 17');

isa_ok( $S, 'FasterStones' );

is_deeply( FasterStones->split_number(23), [2,3], 'split_number(23) is [2,3]');
is_deeply( FasterStones->split_number(123456), [123,456], 'split_number(123456) is [123,456]');
is_deeply( FasterStones->split_number(12340056), [1234,56], 'split_number(12340056) is [1234,56]');

for (1..6){
  $S->next();
}
is( $S->count_stones(), 22, 'count_stones() is 22 after 6 blinks' );
# print Dumper $S;

for (7..25){ $S->next(); }
is( $S->count_stones(), 55312, 'count_stones() is 55312 after 25 blinks' );

