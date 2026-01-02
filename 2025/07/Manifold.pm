package Manifold;
use strict;
use Data::Dumper;

sub new {
  my ($class, @lines) = @_;

  my $self->{rows} = \@lines;

  my @char;
  for my $row (@lines){
    chomp $row;

    my @ch = split '', $row;
    push @char, \@ch;
  }
  $self->{ch} = \@char;

  bless $self, $class;
}

sub split_count {
  my $self = shift;

  my $count = 0;

  $self->set_pipe_at(1, $self->S_column());

  for my $row (1 .. $self->height() - 1){
    for my $col (0 .. $self->width()){
      next unless $self->is_pipe_at($row, $col);
      if ($self->is_carat_at($row+1, $col)) {
        $count++;
        $self->set_pipe_at($row+1,$col-1);
        $self->set_pipe_at($row+1,$col+1);
      }
      else {
        $self->set_pipe_at($row+1,$col);
      }
    }
  }
  return $count;
}

sub timelines {
  my ($self, $row, $col, $current_track, $all_tracks) = @_;

  $current_track .= "($row,$col)";

  # a track has been completed
  if ($row > $self->height()){
    push @$all_tracks, $current_track;
    return;
  }

  # we are at a branch (carat signifies branching)
  if ($self->is_carat_at($row, $col)){
    $self->timelines($row+1, $col-1, $current_track, $all_tracks);
    $self->timelines($row+1, $col+1, $current_track, $all_tracks);
  }
  else {
    $self->timelines($row+1, $col, $current_track, $all_tracks);
  }
}

sub count_paths {
  my ($self, $row, $col, $memo) = @_;

  # Base case: reached beyond the grid
  return 1 if $row > $self->height();

  # Check memoization cache
  my $key = "$row,$col";
  return $memo->{$key} if exists $memo->{$key};

  my $count = 0;

  # Branch point
  if ($self->is_carat_at($row, $col)) {
    $count += $self->count_paths($row+1, $col-1, $memo);
    $count += $self->count_paths($row+1, $col+1, $memo);
  }
  else {
    $count += $self->count_paths($row+1, $col, $memo);
  }

  # Store in cache
  $memo->{$key} = $count;
  return $count;
}


sub print_matrix {
  my $self = shift;

  for my $row (0 .. $self->height()){
    for my $col (0 .. $self->width()){
      print $self->{ch}->[$row]->[$col];
    }
  print "\n";
  }
}

sub is_char_at{
  my ($self, $char, $row, $col) = @_;
  $self->{ch}->[$row]->[$col] eq $char;
}

sub set_pipe_at{
  my ($self, $row, $col) = @_;
  $self->{ch}->[$row]->[$col] = '|';
}

sub is_pipe_at {
  my ($self, $row, $col) = @_;
  $self->is_char_at('|',$row,$col);
}

sub is_carat_at {
  my ($self, $row, $col) = @_;
  $self->is_char_at('^',$row,$col);
}

sub S_column {
  my $self = shift;

  my $i = 0;
  for my $char (@{$self->{ch}->[0]}){
    return $i if $char eq 'S';
    $i++;
  }
  die "didn't find S";
}

sub height {
  my $self = shift;
  scalar @{$self->{ch}} - 1;
}

sub width {
  my $self = shift;
  scalar @{$self->{ch}->[0]} - 1;
}

1;
