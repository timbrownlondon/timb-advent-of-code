package Merge;
use strict;
use Data::Dumper;


sub merge {
  my ($class, $a, $b) = @_;

  my ($a1, $a2) = $a =~ m/(\d+)-(\d+)/ or die "don't like $a\n";
  my ($b1, $b2) = $b =~ m/(\d+)-(\d+)/ or die "don't like $b\n";

  die "bad range $a" if $a1 > $a2;
  die "bad range $b" if $b1 > $b2;

  if ($a2 < $b1 or $b2 < $a1){
    # a and b are separate
    return;
  }

  if ($a1 <= $b1 and $a2 >= $b2){
    # a encloses b
    return $a;
  }

  if ($a1 <= $b1 and $a2 < $b2){
    # a and b overlap 
    return "$a1-$b2";
  }

  if ($b1 <= $a1 and $b2 < $a2){
    # a and b overlap 
    return "$b1-$a2";
  }

  if ($b1 <= $a1 and $b2 >= $a2){
    # b encloses a
    return $b;
  }

  die "another case";
}

1;
