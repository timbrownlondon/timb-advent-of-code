package Map;
use strict;
use lib '.';
use Direction;
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

  # init some stuff TODO - tidy this
  $self->direction(Direction->new('up'));
  $self->start_x_position();

  $self;
}

sub show {
  my $self = shift;

  for my $y (0..$self->height() -1){
    for my $x (0..$self->width() -1){
      print $self->grid()->[$y][$x];
    }
    print "\n";
  }
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

sub direction {
  my ($self, $direction) = @_;

  $self->{direction} = $direction if $direction;

  $self->{direction};
}

sub start_y_position {
  my $self = shift;

  return $self->{start_y_position} if $self->{start_y_position};

  my $y = 0;
  for my $line (@{$self->{lines}}){
    if( $line =~ m/\^/ ){
      $self->{start_y_position} = $y;
      $self->y_position($y);
      return $y;
    }
    $y++;
  }
  die 'cannot find start_y_position';
}

sub start_x_position {
  my $self = shift;

  return $self->{start_x_position} if $self->{start_x_position};

  my $y = $self->start_y_position();
  my $x = 0;
  for my $char ( @{$self->grid()->[$y]} ){
    if( $char eq '^' ){
      $self->{start_x_position} = $x;
      $self->x_position($x);
      return $x;
    }
    $x++;
  }
  die 'cannot find start_x_position';
}


sub move_until_fall_off_grid {
  my $self = shift;
  my $i = 0;
  while( $self->position_is_on_grid() ){
    $self->move_one_place();
    $i++;
    return $i if $i > 10000;
  }
  return scalar @{$self->route()};
}

sub move_one_place {
  my $self = shift;

  my $x = $self->x_position();
  my $y = $self->y_position();

  my $i = 0;
  while ( $self->is_barrier__ahead() ){
    $self->direction()->turn_right();
    die 'turned right too many times' if ++$i > 4;
  }

  my $char = $self->direction()->char();
  $self->set_cell($x, $y, $char);
  
  # move
  $self->update_x_by( $self->direction()->x_move() );
  $self->update_y_by( $self->direction()->y_move() );

  $self->add_to_route($x, $y, $char);
}

sub is_barrier__ahead {
  my $self = shift;

  # look ahead to see if there is a barrier
  my $x_ahead = $self->x_position() + $self->direction()->x_move();
  my $y_ahead = $self->y_position() + $self->direction()->y_move();

  return 0 if $x_ahead < 0;
  return 0 if $y_ahead < 0;
  return 0 if $x_ahead >= $self->width();
  return 0 if $y_ahead >= $self->height();

  return 1 if $self->grid()->[$y_ahead][$x_ahead] eq '#';
  return 1 if $self->grid()->[$y_ahead][$x_ahead] eq 'O';

  return 0;
}

sub position_is_on_grid {
  my $self = shift;

  return 0 if $self->x_position() < 0;
  return 0 if $self->y_position() < 0;
  return 0 if $self->x_position() >= $self->width();
  return 0 if $self->y_position() >= $self->height();

  return 1;
}
sub set_cell {
   my ($self, $x, $y, $char) = @_;

   $self->grid()->[$y][$x] = $char;
}


sub update_x_by {
  my ($self, $value) = @_;
  $self->x_position( $self->x_position() + $value );
}

sub update_y_by {
  my ($self, $value) = @_;
  $self->y_position( $self->y_position() + $value );
}

sub x_position {
  my ($self, $value) = @_;
  $self->{x_position} = $value if defined $value;
  $self->{x_position};
}

sub y_position {
  my ($self, $value) = @_;
  $self->{y_position} = $value if defined $value;
  $self->{y_position};
}

sub x_direction {
  my ($self, $value) = @_;
  $self->{x_direction} = $value if defined $value;
  $self->{x_direction};
}

sub y_direction {
  my ($self, $value) = @_;
  $self->{y_direction} = $value if defined $value;
  $self->{y_direction};
}

sub count_visited_cells {
  my $self = shift;

  my $count = 0;
  for my $y (0..$self->height() -1){
    for my $x (0..$self->width() -1){
      $count++ if Direction->is_visited_char( $self->grid()->[$y][$x] );
    }
  }
  return $count;
}

sub cells_with_char {
  my ($self, $char) = @_;

  my @cells;
  for my $y (0..$self->height() -1){
    for my $x (0..$self->width() -1){
      push @cells, [$x,$y] if $self->grid()->[$y][$x] eq $char;
    }
  }
  \@cells;
}

sub route {
  my $self = shift;
  $self->{route};
}

sub add_to_route {
  my ($self, $x, $y, $d) = @_;

  $self->{uniq_points}->{"$x $y $d"}++;

  if ($self->{uniq_points}->{"$x $y $d"} > 1 ){
    $self->{loop_start} = [$x, $y, $d];
  }

  push @{$self->{route}}, [$x, $y, $d];
}

sub is_loop {
  my $self = shift;

  $self->{loop_start};
}

1;
