use Test::More tests => 18;
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
#
# these can be solved once we introduce 
# contatenation (ie. Part 2)
# 156: 15 6 can be made true through a single concatenation: 15 || 6 = 156.
# 7290: 6 8 6 15 can be made true using 6 * 8 || 6 * 15.
# 192: 17 8 14 can be made true using 17 || 8 + 14.

{
  is(Equation->evaluate([2,0,4,1,7]), 42, 'evaluate([2,0,4,1,7]) is 42');
  is(Equation->evaluate([1,0,4,1,2]), 10, 'evaluate([1,0,4,1,2]) is 10');
  is(Equation->evaluate([1,2,4,1,2]), 28, 'evaluate([1,2,4,1,2]) is 28');
}

{
  my $EQ = Equation->new_from_string('190: 10 19');
  $EQ->number_of_operators(2);
  is_deeply($EQ->operator_lists(), [[0],[1]], 'operator_lists() for 2 numbers');
  is_deeply($EQ->expressions(), [[10,0,19],[10,1,19]], 'expressions() for 2 numbers');
  ok($EQ->solve(), 'solve() for 2 numbers');
}

{
  my $EQ = Equation->new_from_string('3267: 81 40 27');
  $EQ->number_of_operators(2);
  is_deeply($EQ->operator_lists(), [[0,0],[1,0],[0,1],[1,1]], 'operator_lists() for 3 numbers');
  is_deeply($EQ->expressions(), [[81,0,40,0,27],[81,1,40,0,27], [81,0,40,1,27],[81,1,40,1,27]], 'expressions() for 3 numbers');
  ok($EQ->solve(), 'solve() for 3 numbers');
}

{
  my $EQ = Equation->new_from_string('21037: 9 7 18 13');
  $EQ->number_of_operators(2);
  ok( ! $EQ->solve(), 'NOT solve() for 4 numbers');
}

# added for Part 2
{
  my $EQ = Equation->new_from_string('156: 15 6');
  $EQ->number_of_operators(3);
  is_deeply($EQ->n_as_base_array(0,[]), [0], 'n_as_base_array(0,[]) is [0]');
  is_deeply($EQ->n_as_base_array(2,[]), [2], 'n_as_base_array(2,[]) is [2]');
  is_deeply($EQ->operator_lists(), [[0],[1],[2]], 'operator_lists() for 2 numbers is [[0],[1],[2]]');
  ok($EQ->solve(), 'solve() for 2 numbers with 3 operations');
}

{
  my $EQ = Equation->new_from_string('192: 17 8 14');
  $EQ->number_of_operators(3);
  is_deeply($EQ->operator_lists(), [[0,0],[1,0],[2,0],[0,1],[1,1],[2,1],[0,2],[1,2],[2,2]], 'operator_lists() for 3 numbers');
  ok($EQ->solve(), 'solve() for 3 numbers with 3 operations');
}

{
  my $EQ = Equation->new_from_string('7290: 6 8 6 15');
  $EQ->number_of_operators(3);
  ok($EQ->solve(), 'solve() for 4 numbers with 3 operations');

# for my $i (0..27){
#   print Dumper $EQ->n_as_base_array($i,[]);
# }
}

