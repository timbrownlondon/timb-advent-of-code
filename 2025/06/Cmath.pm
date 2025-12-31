package Cmath;
use strict;
use Data::Dumper;

sub new {
  my ($class, @lines) = @_;

  my $self->{rows} = \@lines;

  my @grid;
  my @char;
  for my $row (@lines){
    chomp $row;

    # data structure needed for part 2
    my @ch = split '', $row;
    push @char, \@ch;

    # data structure needed for part 1
    $row =~ s/^\s+//;
    push @grid, [split /\s+/, $row];
  }
  $self->{grid} = \@grid;
  $self->{ch} = \@char;

  bless $self, $class;
}

sub get_column {
  my ($self, $i) = @_;

  my @column;
  for my $row (@{$self->{grid}}){
    push @column, $row->[$i];
  }
  return \@column;
}

sub height() {
  my $self = shift;
  return @{$self->{ch}} - 1;
}

sub width() {
  my $self = shift;
  return @{$self->{ch}->[0]} + 1;
}

sub operator_row {
  my $self = shift;

  my $h = $self->height();
  $self->{ch}->[$h];
}

sub get_char_list {
  my ($self, $i) = @_;

  my @list;
  for my $k (0 .. $self->height){
    push @list, $self->{ch}->[$k]->[$i];
  }
  return \@list;
}

sub operator_indices {
  my $self = shift;

  my @indices;
  my $i = 0;
  for my $ch (@{$self->operator_row()}){
    push @indices, $i if $ch =~ m/[*\+]/;;
    $i++;
  }
  push @indices, $self->width();
  return \@indices;
}

sub total_part2 {
  my $self = shift;

  my ($first, @indices) = @{$self->operator_indices()};
  die "expecting zero got $first" unless $first == 0;

  my $total = 0;
  for my $n (@indices){
    my $slice = $self->get_matrix_data_at($first , $n - 2);
    $total += $self->eval_matrix_data($slice);
    $first = $n;
  }
  return $total;
}

sub get_matrix_data_at {
  my ($self, $i,$j) = @_;

   # $i and $j are horizontal indices
   # we need to get the slice of numeric data between them
   my @matrix;
   for my $k ($i .. $j){
     my @col;
     for my $row (0 .. $self->height()){
       my $element =  $self->{ch}->[$row]->[$k];
       push @col, $element;
     }
       push @matrix, \@col;
   }
   return \@matrix;
}

sub eval_matrix_data {
  my ($self, $d) = @_;

  my $value = join '', @{$d->[0]};
  my $op = chop  $value;
  die unless $op eq '*' or $op eq '+';

  for my $i (1 .. @$d - 1){
    my $number = join '', @{$d->[$i]};
    $value += $number if $op eq '+';
    $value *= $number if $op eq '*';
  }
  return $value;
}


# methods for part 1
sub column_value {
  my ($self, $i) = @_;

  my $col = $self->get_column($i);
  my $last_index = @{$self->{rows}} - 1;

  my $operator = $col->[-1];

  my $value = $col->[0];

  for my $k (1 .. $last_index-1){
    $value += $col->[$k] if $operator eq '+';
    $value *= $col->[$k] if $operator eq '*';
  }
  return $value
}

sub total_value {
  my $self = shift;

  my $total = 0;
  my $last_index = scalar @{$self->{grid}->[0]} - 1;
  for my $i (0 .. $last_index){
    $total += $self->column_value($i);
  }
  return $total
}

1;
