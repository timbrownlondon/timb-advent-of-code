use Test::More; 
use lib '.';
use Data::Dumper;
use_ok Valid;
use strict;

my $V = Valid->new('125 17');
isa_ok( $V, 'Valid' );

is ($V->is_invalid_10_digit(1234512345), 1, '1234512345 is invalid');
is ($V->is_invalid_10_digit(9898989898), 1, '9898989898 is invalid');
is ($V->is_invalid_10_digit(4444444444), 1, '4444444444 is invalid');
is ($V->is_invalid_10_digit(1234567890), 0, '123123123 is NOT invalid');

ok ($V->is_invalid_9_digit(123123123), '123123123 is invalid');
is ($V->is_invalid_9_digit(123123123), 1, '123123123 is invalid');
is ($V->is_invalid_9_digit(222222222), 1, '123123123 is invalid');
is ($V->is_invalid_9_digit(123456789), 0, '123123123 is NOT invalid');
is ($V->is_invalid_9_digit(123113123), 0, '123123123 is NOT invalid');

is ($V->is_invalid_8_digit(12345678), 0, '12345678 is NOT invalid');
is ($V->is_invalid_8_digit(12341234), 1, '12341234 is invalid');
is ($V->is_invalid_8_digit(12121212), 1, '12121212 is invalid');
is ($V->is_invalid_8_digit(11111111), 1, '11111111 is invalid');

is ($V->is_invalid_7_digit(1234567), 0, '1234567 is NOT invalid');
is ($V->is_invalid_7_digit(7777777), 1, '7777777 is invalid');

is ($V->is_invalid_6_digit(123456), 0, '123456 is NOT invalid');
is ($V->is_invalid_6_digit(123123), 1, '123123 is invalid');
is ($V->is_invalid_6_digit(121212), 1, '121212 is invalid');

is ($V->is_invalid_5_digit(12345), 0, '12345 is NOT invalid');
is ($V->is_invalid_5_digit(55555), 1, '55555 is invalid');

is ($V->is_invalid_4_digit(1234), 0, '1234 is NOT invalid');
is ($V->is_invalid_4_digit(1212), 1, '1212 is invalid');

is ($V->is_invalid_3_digit(123), 0, '123 is NOT invalid');
is ($V->is_invalid_3_digit(333), 1, '333 is invalid');

is ($V->is_invalid_2_digit(12), 0, '12 is NOT invalid');
is ($V->is_invalid_2_digit(22), 1, '22 is invalid');

# dispatch to the appropraite subrountines
ok ($V->is_valid(1234), '1234 is valid');
ok (! $V->is_valid(22), '22 is NOT valid');
ok (! $V->is_valid(1234512345), '1234512345 is NOT valid');

done_testing();

# done_testing(25);

