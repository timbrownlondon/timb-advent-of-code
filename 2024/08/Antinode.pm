package Antinode;
use strict;
use Data::Dumper;

sub new_from_string{
  my ($class, $str) = @_;

  my @trimmed;
    for (split /\n/, $str){
    chomp;
    push @trimmed, $_;
  }
  my $self;
  $self->{string} = $str;
  $self->{lines} = \@trimmed;

  bless $self, $class;
}

sub include_harmonics {
  my ($self, $bool) = @_;
  $self->{harmonics} = $bool;
}

sub width {
  my $self = shift;
 length $self->{lines}->[0];
}

sub height {
  my $self = shift;
  scalar @{$self->{lines}};
}

sub grid {
  my $self = shift;

  return $self->{grid} if $self->{grid};

  my @collector;
  for my $line (@{$self->{lines}}){
    my @chars = split '', $line;
    die 'line lengths are not uniform' unless @chars == $self->width();
    push @collector, \@chars;
  }
  $self->{grid} = \@collector;
}

sub antenna_points {
  my $self = shift;

  return $self->{locations} if $self->{locations};

  my $count;
  my $locations;
  for my $y (0 .. $self->height() -1){
    for my $x (0 .. $self->width() -1){
      my $ch = $self->grid()->[$y][$x];
      next if $ch eq '.';
      if ( $locations->{$ch} ){
        push @{$locations->{$ch}}, [$x,$y];
      }
      else {
        $locations->{$ch} = [[$x,$y]];
      }
    }
  }
  $self->{locations} = $locations;
}

sub antenna_chars {
  my $self = shift;

  my @chars = sort keys %{$self->antenna_points()};
  \@chars;
}

sub is_on_grid {
  my ($self, $point) = @_;

  my ($x,$y) = @$point;
  $x >= 0 and $x < $self->width() and $y >= 0 and $y < $self->height();
}

sub antinodes_for_pair {
  my ($self, $a, $b) = @_;

  my ($ax, $ay) = @$a;
  my ($bx, $by) = @$b;

  [[2 * $ax - $bx, 2 * $ay - $by],[2 * $bx - $ax, 2 * $by - $ay]];
}

sub antinodes_for_pair_with_harmonics {
  my ($self, $a, $b) = @_;

  my ($ax, $ay) = @$a;
  my ($bx, $by) = @$b;

  my $delta_x = $ax - $bx;
  my $delta_y = $ay - $by;

  my @points;

  
  my $intervals = int($self->width() / abs($delta_x));
  $intervals = int($self->height() / abs($delta_y)) if int($self->height() / abs($delta_y)) > $intervals;
  
  for my $i (-1 * $intervals .. $intervals){
    my $pt = [$i * $delta_x + $ax, $i * $delta_y + $ay];
    # next if $pt->[0] == $ax and $pt->[1] == $ay;
    # next if $pt->[0] == $bx and $pt->[1] == $by;

    push @points, $pt if $self->is_on_grid($pt);
  }
  \@points;
}

sub antinodes_for_char {
  my ($self, $char) = @_;

  my @points = @{$self->antenna_points()->{$char}}; 
  my @collect;

  for my $i (0 .. scalar @points -1){
    for my $j ($i +1  .. scalar @points -1){
      $self->{harmonics} ?
        push @collect, @{$self->antinodes_for_pair_with_harmonics($points[$i], $points[$j])} :
        push @collect, @{$self->antinodes_for_pair($points[$i], $points[$j])};
    }
  }
  \@collect;
}

sub all_antinodes {
  my $self = shift;

  my @points;
  for my $ch (sort @{$self->antenna_chars()}){
    push @points, @{$self->antinodes_for_char($ch)};
  }
  \@points;
}

sub antinode_count {
  my $self = shift;

  my $dedupe;
  my $count = 0;
  for my $point (@{$self->all_antinodes()}){
    next if $dedupe->{$point->[0]}->{$point->[1]};
    $dedupe->{$point->[0]}->{$point->[1]}++;
    $count++ if $self->is_on_grid($point);
  }
  $count;
}

sub show_antinodes {
  my $self = shift;

  my $grid;
  for my $antinode (@{$self->all_antinodes()}){
    next unless $self->is_on_grid($antinode);
    $grid->[$antinode->[0]]->[$antinode->[1]] = '#';
  }

  for my $y (0 .. $self->height() -1){
    for my $x (0 .. $self->width() -1){
      $grid->[$x]->[$y] ?
        print '#' : print '.';
    }
    print "\n";
  }
}

1;
