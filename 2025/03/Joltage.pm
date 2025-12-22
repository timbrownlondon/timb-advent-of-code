package Joltage;
use strict;
use Data::Dumper;

sub new {
  my $class = shift;
  my $self;
  bless \$self, $class;
}

sub jolt {
  my ($self, $number) = @_;

  my @digit = split '', $number;

  my $tens = 0;
  my $position;
  for my $i (0 .. length("$number") - 2){
    if ($digit[$i] > $tens){
      $tens = $digit[$i];
      $position = $i;
    }
  }

  my $units = 0;
  for my $i ($position + 1 .. length("$number") - 1){
    if ($digit[$i] > $units){
      $units = $digit[$i];
    }
  }

  return $tens . $units;
}

sub twelve_digit_jolt {
  my ($self, $number) = @_;
  my $len = length "$number";
  warn $len;

  my @digit = split '', "$number";
  my @result;
  my $position = 0;

  warn Dumper \@digit;

  for (0 .. 11){
    my $end_index = $position + 10;
    $end_index = $len if $end_index > $len;

    my $start_index = $position;
    my $slice_length = $end_index - $start_index;

    my $pair = $self->highest_and_place(@digit[$position ..  $end_index]);
    push @result, $pair->[0];
    $position += $pair->[1];
    warn "Position is now $position\n";
    # warn Dumper \@result;
  }

  return $result[0].$result[1].$result[2].$result[3].$result[4].$result[5].$result[6].$result[7].$result[8].$result[9].$result[10].$result[11]

}

sub highest_and_place {
  shift;

  my $value = 0;
  my $position = 0;
  my $i = 0;

  for my $d (@_){
    $i++;
    next unless $d > $value;
    $value = $d;
    $position = $i;
  }
  warn ">>>>> $value ($position)";
  return [$value, $position];
}

1;
