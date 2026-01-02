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
  $self->{points} = \@points;

  bless $self, $class;
}

sub point {
  my ($self, $i) = @_;
  $self->{points}->[$i];
}

sub closest_points {
  my $self = shift;

  my $D = $self->distances();

  my $first = 0;
  my $second = 1;
  my $lowest_distance =  $D->{0}->{1};
  for my $i (0 .. $#{$self->{points}}){
    for my $j ($i + 1  .. $#{$self->{points}}){
      my $dist = $D->{$i}->{$j};
      next unless $dist < $lowest_distance;
      $lowest_distance = $dist;
      $first = $i;
      $second = $j
    }
  }
  return [$first,$second];
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
