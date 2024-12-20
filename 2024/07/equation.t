use Test::More tests => 10;
use lib '.';
use_ok Equation;
use Data::Dumper;
use strict;

# soluble examples
# 190: 10 19
# 3267: 81 40 27
# 292: 11 6 16 20
#
# insoluble examples
# 83: 17 5
# 156: 15 6
# 7290: 6 8 6 15
# 161011: 16 10 13
# 192: 17 8 14
# 21037: 9 7 18 13

{
  is(Equation->evaluate([2,0,4,1,7]), 42, 'evaluate([2,0,4,1,7]) is 42');
  is(Equation->evaluate([1,0,4,1,2]), 10, 'evaluate([1,0,4,1,2]) is 10');
}

{
  my $EQ = Equation->new_from_string('190: 10 19');
  is_deeply($EQ->operator_lists(), [[0],[1]], 'operator_lists() for 2 numbers');
  is_deeply($EQ->expressions(), [[10,0,19],[10,1,19]], 'expressions() for 2 numbers');
  ok($EQ->solve(), 'solve() for 2 numbers');
}

{
  my $EQ = Equation->new_from_string('3267: 81 40 27');
  is_deeply($EQ->operator_lists(), [[0,0],[0,1],[1,0],[1,1]], 'operator_lists() for 3 numbers');
  is_deeply($EQ->expressions(), [[81,0,40,0,27],[81,0,40,1,27], [81,1,40,0,27],[81,1,40,1,27]], 'expressions() for 3 numbers');
  ok($EQ->solve(), 'solve() for 3 numbers');
}

{
  my $EQ = Equation->new_from_string('21037: 9 7 18 13');
  ok( ! $EQ->solve(), 'NOT solve() for 4 numbers');
}


