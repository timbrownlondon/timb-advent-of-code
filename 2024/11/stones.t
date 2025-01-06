use Test::More tests => 11;
use lib '.';
use Data::Dumper;
use_ok Stones;
use strict;

my $S = Stones->new_from_string('125 17');

isa_ok( $S, 'Stones' );


is_deeply( Stones->split_number(23), [2,3], 'split_number(23) is [2,3]');
is_deeply( Stones->split_number(123456), [123,456], 'split_number(123456) is [123,456]');

is( $S->next_string(), '253000 1 7', 'next() is 253000 1 7' );
is( $S->next_string(), '253 0 2024 14168', 'next() is 253 0 2024 14168' );
is( $S->next_string(), '512072 1 20 24 28676032', 'next() is 512072 1 20 24 28676032' );
is( $S->next_string(), '512 72 2024 2 0 2 4 2867 6032', 'next() is 512 72 2024 2 0 2 4 2867 6032' );
is( $S->next_string(), '1036288 7 2 20 24 4048 1 4048 8096 28 67 60 32', 'next() is 1036288 7 2 20 24 4048 1 4048 8096 28 67 60 32' );
is( $S->next_string(), '2097446912 14168 4048 2 0 2 4 40 48 2024 40 48 80 96 2 8 6 7 6 0 3 2', 'next() is 2097446912 14168 4048 2 0 2 4 40 48 2024 40 48 80 96 2 8 6 7 6 0 3 2' );

is( $S->count_stones(), 22, 'count_stones() is 22' );
