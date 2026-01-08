package Circuits;
use strict;
use Data::Dumper;

sub new {
  my ($class, @lines) = @_;


  my $self;
  my @points;
  
  for (@lines){
    m/(\d+),(\d+),(\d+)/ or die "don't like line: $_";
    push @points, Point->new($1, $2, $3);
  }
  # list of all points
  $self->{points} = \@points;

  # list of groups
  $self->{groups} = [];

  # hash of assignments points->[i] to group it's in
  $self->{assigned} = {};

  bless $self, $class;
}

sub point {
  my ($self, $i) = @_;
  $self->{points}->[$i];
}

sub step {
  my ($self, $pair_number) = @_;

  my $pair = $self->ordered_pairs->[$pair_number];
  my $i = $pair->{i};
  my $j = $pair->{j};


  my $i_assignment = $self->{assigned}->{$i};
  my $j_assignment = $self->{assigned}->{$j};

  # nothing to do if i and j are already in the same circuit
  if (defined $i_assignment and $i_assignment == $j_assignment){
    return "points $i and $j are already in same group $i_assignment";
  }

  # if Both i and j are assigned then we need to join their groups
  if (defined $i_assignment and defined $j_assignment){
    my $g = ++$self->{group_count};
    for my $k (keys %{$self->{assigned}}){
      next unless $self->{assigned}->{$k} == $i_assignment
               or $self->{assigned}->{$k} == $j_assignment;
      $self->{assigned}->{$k} = $g;
    }
    return "points $i and $j: groups $i_assignment and $j_assignment merged to be group $g";
  }

  if (defined $i_assignment){
    $self->{assigned}->{$j} = $i_assignment;
    return "point $j added to group $i_assignment";
  }

  if (defined $j_assignment){
    $self->{assigned}->{$i} = $j_assignment;
    return "point $i added to group $j_assignment";
  }
  
  my $g = ++$self->{group_count};
  $self->{assigned}->{$i} = $g;
  $self->{assigned}->{$j} = $g;
  return "points $i and $j added to new group $g";
}

sub groups {
  my $self = shift;

  my $assigned = $self->{assigned};
  my $g;
  for my $point (keys %$assigned){
    $g->{$assigned->{$point}}->{$point}++;
  }
  return $g;
}

sub group_sizes {
  my $self = shift;

  my $groups = $self->groups();
  my @sizes;
  for my $g (keys %$groups){
    push @sizes, scalar keys %{$groups->{$g}};
  }
  @sizes = sort {$b <=> $a} @sizes;
  return \@sizes;
}
sub ordered_pairs {
  my $self = shift;

  return $self->{ordered_pairs} if $self->{ordered_pairs};

  my @pair;
  for my $i (keys %{$self->distances()}){
    for my $j (keys %{$self->distances()->{$i}}){
      push @pair, {dist => $self->{distances}->{$i}->{$j}, i => $i, j => $j};
    }
  }
  @pair = sort {$a->{dist} <=> $b->{dist}} @pair;

  $self->{ordered_pairs} = \@pair; 
}


sub distance_squared {
  my ($self, $p1, $p2) = @_;
  return ($p1->x() - $p2->x())**2 + ($p1->y() - $p2->y())**2 + ($p1->z() - $p2->z())**2;
}

sub distances {
  my $self = shift;
 
  return $self->{distances} if $self->{distances};
 
  my $distances;
  for my $i (0 .. $#{$self->{points}}){
    for my $j ($i + 1  .. $#{$self->{points}}){
      $distances->{$i}->{$j} = $self->distance_squared($self->point($i), $self->point($j));
    }
  }
  $self->{distances} = $distances;
}

package Point;
sub new {
  my ($class, $x, $y, $z) = @_;
  bless {x =>$x, y => $y, z => $z, key => "$x,$y,$z"}, $class
}

sub x { my $self = shift; $self->{x};}
sub y { my $self = shift; $self->{y};}
sub z { my $self = shift; $self->{z};}

1;
