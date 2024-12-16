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
    print $line, "\n";
    if( $line =~ m/\^/ ){
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




1;
