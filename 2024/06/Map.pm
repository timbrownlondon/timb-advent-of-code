package Map;
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

sub start_y_position {
  my $self = shift;

  return $self->{start_y_position} if $self->{start_y_position};

  my $y = 0;
  for my $line (@{$self->{lines}}){
    if( $line =~ m/\^/ ){
      $self->y_direction(-1);
      $self->{start_y_position} = $y;
      return $y;
    }
    $y++;
  }
  die 'cannot find start_y_position';
}

sub start_x_position {
  my $self = shift;

  return $self->{start_x_position} if $self->{start_x_position};

  my $y = $self->{start_y_position};
  my $x = 0;
  for my $char ( @{$self->grid()->[$y]} ){
    if( $char eq '^' ){
      $self->{start_x_position} = $x;
      return $x;
    }
    $x++;
  }
  die 'cannot find start_x_position';
}

sub move_one_place {
  my $self = shift;


}

sub x_direction {
  my ($self, $direction) = @_;

  $self->{x_direction} = $direction if $direction;
  $self->{x_direction} or 0;;
}

sub y_direction {
  my ($self, $direction) = @_;

  $self->{y_direction} = $direction if $direction;
  $self->{y_direction} or 0;;
}


1;
