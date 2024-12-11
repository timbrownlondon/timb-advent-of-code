#!/usr/bin/env perl

use strict;

my $text = join '', <>;
$text =~ s/\n//g;

my @count_do = ($text =~ m/do\(\)/g);
my @count_dont = ($text =~ m/don't\(\)/g);

print "do    ", scalar @count_do, "\n";
print "don't ", scalar @count_dont, "\n";

# remove disabled sections between don't() and do()
$text =~ s/don't\(\).*?do\(\)/<snip>do()/g;

# remove disabled section between don't() and end
$text =~ s/don't\(\).*/<snip>/g;

my @count_do = ($text =~ m/do\(\)/g);
my @count_dont = ($text =~ m/don't\(\)/g);

print "do    ", scalar @count_do, "\n";
print "don't ", scalar @count_dont, "\n";

my @valid_functions = ($text =~ m/(mul\(\d+,\d+\))/g);

my $total = 0;
for my $func (@valid_functions){
  $func =~ m/(\d+),(\d+)/;
  $total += $1 * $2;
}
print "Total: $total\n";
