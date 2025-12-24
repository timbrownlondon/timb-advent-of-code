package Rolls;
use strict;
use Data::Dumper;

sub new {
  my ($class, @text_array) = @_;

  # remove trailing newlines (and anyother whitespace)
  map {s/\s//g} @text_array;

  my $self;
  $self->{map} = \@text_array;
  bless $self, $class;
}

sub row_count {
  my $self = shift;
  return scalar @{$self->{map}};
}

sub col_count {
  my $self = shift;
  return length $self->{map}->[0];
}

sub occupied_neighbour_count {
  my ($self, $x, $y) = @_;
  my @matches =  ($self->neighbours($x,$y) =~ m/@/g);
  return scalar @matches;
}

sub neighbours {
  my ($self, $x, $y) = @_;

  my $str = '';
  $str .= $self->at($x-1, $y-1);
  $str .= $self->at($x,   $y-1);
  $str .= $self->at($x+1, $y-1);
  $str .= $self->at($x-1, $y  );
  $str .= $self->at($x+1, $y  );
  $str .= $self->at($x-1, $y+1);
  $str .= $self->at($x,   $y+1);
  $str .= $self->at($x+1, $y+1);

  return $str;
}

sub at {
  my ($self, $x, $y) = @_;
  
  return '' if $x < 0;
  return '' if $y < 0;
  return '' if $x >= $self->row_count();
  return '' if $y >= $self->col_count();

  my $row = $self->{map}->[$y];
  return substr($row, $x, 1);
}

sub remove_roll_at {
  my ($self, $x, $y) = @_;
  
  return if $x < 0;
  return if $y < 0;
  return if $x >= $self->row_count();
  return if $y >= $self->col_count();

  substr($self->{map}->[$y], $x, 1) = '.';
}


1;
