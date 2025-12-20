package Valid;
use strict;

sub new {
  my $class = shift;

  my @subs = (
    undef,
    \&is_invalid_1_digit,
    \&is_invalid_2_digit,
    \&is_invalid_3_digit,
    \&is_invalid_4_digit,
    \&is_invalid_5_digit,
    \&is_invalid_6_digit,
    \&is_invalid_7_digit,
    \&is_invalid_8_digit,
    \&is_invalid_9_digit,
    \&is_invalid_10_digit
  );

  bless \@subs, $class;
}

sub is_valid {
  my ($self, $n) = @_;
  my $len = length "$n";

  ! $self->[$len]->(undef, $n);
}

# the largest number has ten digits
# 10 long: split in 2, split in 5
#  9 long: split in 3
#  8 long: split in 2, split in 4
#  7 long: split in 7
#  6 long: split in 2, split in 3
#  5 long: split in 5
#  4 long: split in 2
#  3 long: split in 3
#  2 long: split in 2

sub is_invalid_10_digit {
  my ($class, $n) = @_;
  die 'expecting 10 digits' unless length "$n" == 10;

  my $a = substr("$n", 0, 5);
  my $b = substr("$n", 5, 5);
  return 1 if  $a eq $b;

  my $c = substr("$n", 0, 2);
  my $d = substr("$n", 2, 2);
  my $e = substr("$n", 4, 2);
  my $f = substr("$n", 6, 2);
  my $g = substr("$n", 8, 2);
  return 1 if $c eq $d and $e eq $f and $c eq $f and $f eq $g;

  return 0;
}

sub is_invalid_9_digit {
  my ($class, $n) = @_;
  die 'expecting 9 digits' unless length "$n" == 9;

  my $a = substr("$n", 0, 3);
  my $b = substr("$n", 3, 3);
  my $c = substr("$n", 6, 3);
  return 1 if $a eq $b and $b eq $c;

  return 0;
}

sub is_invalid_8_digit {
  my ($class, $n) = @_;
  die 'expecting 8 digits' unless length "$n" == 8;

  my $a = substr("$n", 0, 4);
  my $b = substr("$n", 4, 4);
  return 1 if $a eq $b;

  return 0;
}

sub is_invalid_7_digit {
  my ($class, $n) = @_;
  die 'expecting 7 digits' unless length "$n" == 7;

  my @ch = split '', "$n";
  return 1 if $ch[0] eq $ch[1] and $ch[1] eq $ch[2] and $ch[2] eq $ch[3] and
              $ch[3] eq $ch[4] and $ch[4] eq $ch[5] and $ch[5] eq $ch[6];

  return 0;
}

sub is_invalid_6_digit {
  my ($class, $n) = @_;
  die 'expecting 6 digits' unless length "$n" == 6;

  my $a = substr("$n", 0, 3);
  my $b = substr("$n", 3, 3);

  return 1 if $a eq $b;

  my $c = substr("$n", 0, 2);
  my $d = substr("$n", 2, 2);
  my $e = substr("$n", 4, 2);
  return 1 if $c eq $d and $d eq $e;

  return 0;
}

sub is_invalid_5_digit {
  my ($class, $n) = @_;
  die 'expecting 5 digits' unless length "$n" == 5;

  my @ch = split '', "$n";
  return 1 if $ch[0] eq $ch[1] and $ch[1] eq $ch[2] and $ch[2] eq $ch[3] and
              $ch[3] eq $ch[4] and $ch[4];

  return 0;
}

sub is_invalid_4_digit {
  my ($class, $n) = @_;
  die "expecting 4 digits for $n" unless length "$n" == 4;

  my $a = substr("$n", 0, 2);
  my $b = substr("$n", 2, 2);

  return 1 if $a eq $b;

  return 0;
}

sub is_invalid_3_digit {
  my ($class, $n) = @_;
  die 'expecting 3 digits' unless length "$n" == 3;

  my @ch = split '', "$n";
  return 1 if $ch[0] eq $ch[1] and $ch[1] eq $ch[2];

  return 0;
}

sub is_invalid_2_digit {
  my ($class, $n) = @_;
  die 'expecting 2 digits' unless length "$n" == 2;

  my @ch = split '', "$n";
  return 1 if $ch[0] eq $ch[1];

  return 0;
}

sub is_invalid_1_digit {
  return 0;
}

1;
