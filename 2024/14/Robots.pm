package Robots;

use strict;

sub new_from_string {
  my ($class, $width, $height, $str) = @_;

  my @robots;
  for (split /\n/, $str){
    m/p=(\d+),(\d+) v=([-\d]+),([-\d]+)/ or die "Cannot parse $_\n";
    push @robots, {x => $1, y => $2, vx => $3, vy => $4 };
  }
  my $self = {
    robots => \@robots,
    width => $width,
    height => $height,
  };

  bless $self, $class;
}

sub move_for_100_seconds {
  my $self = shift;

  for my $bot (@{$self->{robots}} ){
    $bot->{x_100} = ($bot->{x} + 100 * $bot->{vx}) % $self->{width} + 1;
    $bot->{y_100} = ($bot->{y} + 100 * $bot->{vy}) % $self->{height} + 1;
  }
  $self;
}

sub show_100_positions {
  my $self = shift;

  for my $bot (@{$self->{robots}} ){
    next if $bot->{x_100} == ($self->{width} + 1)/2;
    next if $bot->{y_100} == ($self->{height} + 1)/2;

    printf "%d, %d\t%0.1f %0.1f\n", $bot->{x_100}, $bot->{y_100}, $bot->{x_100} / $self->{width}, $bot->{y_100} / $self->{height};
  }
}

sub count_quadrants {
  my $self = shift;

  my $quad;
  for my $bot (@{$self->{robots}} ){
    next if $bot->{x_100} == ($self->{width} + 1)/2;
    next if $bot->{y_100} == ($self->{height} + 1)/2;

    my $x_quotiant = $bot->{x_100} / $self->{width};
    my $y_quotiant = $bot->{y_100} / $self->{height};

    $quad->{top_left}++     if $x_quotiant < 0.5 and $y_quotiant < 0.5;
    $quad->{top_right}++    if $x_quotiant > 0.5 and $y_quotiant < 0.5;
    $quad->{bottom_left}++  if $x_quotiant < 0.5 and $y_quotiant > 0.5;
    $quad->{bottom_right}++ if $x_quotiant > 0.5 and $y_quotiant > 0.5;
  }
  $quad;
}

sub safety_factor {
  my $self = shift;

  my $quad = $self->count_quadrants();

  $quad->{top_left} * 
  $quad->{top_right} * 
  $quad->{bottom_left} * 
  $quad->{bottom_right} 
}

1;
