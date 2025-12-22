use Test::More; 
use lib '.';
use Data::Dumper;
use_ok Joltage;
use strict;

my $J= Joltage->new();
isa_ok( $J, 'Joltage' );

is ($J->jolt('987654321111111'), '98', 'jolt 987654321111111 is 98');
is ($J->jolt('811111111111119'), '89', 'jolt 811111111111119 is 89');
is ($J->jolt('234234234234278'), '78', 'jolt 234234234234278 is 78');
is ($J->jolt('818181911112111'), '92', 'jolt 818181911112111 is 92');

is_deeply ($J->highest_and_place(1,2,3,4,5,1,2), [5,5], 'highest_and_place(1,2,3,4,5,1,2) is [5,5]');
is_deeply ($J->highest_and_place(5,5,5,5,5,1,2), [5,1], 'highest_and_place(5,5,5,5,5,1,2) is [5,1]');
is_deeply ($J->highest_and_place(5,5,5,5,5,1,9), [9,7], 'highest_and_place(5,5,5,5,5,1,9) is [9,7]');

is ($J->twelve_digit_jolt('987654321111111'), '987654321111', 'jolt 987654321111111 is 987654321111');
is ($J->twelve_digit_jolt('811111111111119'), '811111111119', 'jolt 811111111111119 is 811111111119');


done_testing();
