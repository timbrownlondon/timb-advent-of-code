use Test::More; 
use lib '.';
use Data::Dumper;
use Merge;
use strict;

is (Merge->merge('1-10', '5-15'), '1-15', 'merge 1-10 with 5-15 -> 1-15');
is (Merge->merge('5-15', '1-10'), '1-15', 'merge 5-15 with 1-10 -> 1-15');

is (Merge->merge('1-20', '1-10'), '1-20', 'merge 1-20 with 1-10 -> 1-20');
is (Merge->merge('9-11', '1-11'), '1-11', 'merge 9-11 with 1-11 -> 1-11');

is (Merge->merge('9-11', '11-21'), '9-21', 'merge 9-11 with 11-21 -> 9-21');
is (Merge->merge('9-11', '2-9'), '2-11', 'merge 9-11 with 2-9 -> 2-9');

ok (! Merge->merge('9-11', '15-17'), '9-11 and 15-17 dont merge');
ok (! Merge->merge('19-25', '15-17'), '19-25 and 15-17 dont merge');


done_testing();
