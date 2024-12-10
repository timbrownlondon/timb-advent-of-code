#!/usr/bin/env perl

use strict;

sub main{
  while(<>){
    my @values = m/(\d+)/g or die "cannot parse line $_";
    print @values, "\n";
  }
}


sub is_safe{

  1;
}

# choose to run main(0 or tests()
($ARGV[0] =~ m/test/)? tests() : main();


sub tests{
  require Test::More;
  import Test::More tests => 10;

  ok(is_safe(qw|27 29 30 33 34 35 37 35|), 'safe increasing');
  ok(is_safe(qw|51 53 54 55 57 60 63 63|), 'not safe, 63 follows 63');
  ok(is_safe(qw|87 90 93 94 98|), 'not safe, 94 to 98 too large jump');
  ok(is_safe(qw|41 42 45 47 49 51 53 58|), 'not safe, 53 to 58 to large jump');
  ok(is_safe(qw|23 26 23 24 27 28|), 'not safe, going up then down');
  ok(is_safe(qw|32 33 36 37 34 36 39 37|), 'not safe, going up then down');
}
