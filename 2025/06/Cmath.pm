package Cmath;
use strict;
use Data::Dumper;

sub new {
  my ($class, @lines) = @_;

  my $self->{rows} = \@lines;

  my @grid;
  for my $row (@lines){
    $row =~ s/^\s+//;
    push @grid, [split /\s+/, $row];
  }
  $self->{grid} = \@grid;

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
  warn $last_index;
  for my $i (0 .. $last_index){
    $total += $self->column_value($i);
  }
  return $total
}

1;
