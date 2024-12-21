use Test::More tests => 3;
use lib '.';
use Data::Dumper;
use_ok BridgeRepair;
use strict;

my $str = <<ENDSTR;
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
ENDSTR

{
  my $BR = BridgeRepair->new_from_string(2, $str);
  is($BR->total(), 3749, 'total() is 3749 for 2 operators');
}

{
  my $BR = BridgeRepair->new_from_string(3, $str);
  is($BR->total(), 11387, 'total() is 11387 for 3 operators');
}
