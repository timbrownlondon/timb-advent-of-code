use Test::More tests => 11;
use lib '.';
use Data::Dumper;
use_ok PrintingSpec;
use strict;

my $rules_str = <<END_RULES;
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13
END_RULES
my @rules = split /\n/, $rules_str;

my $updates_str = <<END_UPDATES;
75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
END_UPDATES
my @updates = split /\n/, $updates_str;

my $PS = PrintingSpec->new(\@rules, \@updates);

# print Dumper $PS;

is(scalar @{$PS->rules()}, 21, 'rules() has correct number of items');
is(scalar @{$PS->updates()}, 6, 'updates() has correct number of items');

is($PS->middle_element_of([1,2,3,4,5,6,7]), 4, 'middle_element_of()');

ok($PS->update_obeys_rule([75,47,61,53,29], [47,53]), 'update_obeys_rule() return true');
ok($PS->update_obeys_rule([75,99,61,53,29], [47,53]), 'update_obeys_rule() return true');
ok($PS->update_obeys_rule([75,47,61,99,29], [47,53]), 'update_obeys_rule() return true');
ok(! $PS->update_obeys_rule([75,47,61,53,29], [53,47]), 'update_obeys_rule() return false');

ok($PS->update_is_valid([97,61,53,29,13]), 'update_is_valid() returns true');
ok(! $PS->update_is_valid([75,97,47,61,53]), 'update_is_valid() returns false');

is($PS->sum_of_middle_element_of_valid_updates(), 143, 'sum_of_middle_element_of_valid_updates()');


