package WordSearch {

sub new {
  my ($class, $lines) = @_;

  my $self->{lines} = $lines;

  bless $self, $class;
  return $self;
}
    
sub count_matches{
  my ($self, $match_string) = @_;
  my $count = 0;

  for my $line (@{$self->{lines}}){
    my @found = ($line =~ m/$match_string/g);
    $count += scalar @found;
  }
  return $count; 
}

sub count_matches_on_rotated{
  my ($self, $match_string) = @_;
  my $count = 0;

  for my $line (@{$self->rotated()}){
    my @found = ($line =~ m/$match_string/g);
    $count += scalar @found;
  }
  return $count; 
}

sub height{
  my $self = shift;
  scalar @{$self->{lines}};
}

sub width{
  my $self = shift;
  length $self->{lines}->[0];
}

sub as_matrix{
  my $self = shift;

  return $self->{matrix} if $self->{matrix};

  my $matrix;
  for my $line (@{$self->{lines}}){
    my @chars = split //, $line;
    push @$matrix, \@chars;
  }
  $self->{matrix} = $matrix;
}

sub rotated{
  my $self = shift;

  return $self->{rotated} if $self->{rotated};

  my $matrix = $self->as_matrix();

  my $rotated;
  for my $y (0..$self->height()-1){
    for my $x (0..$self->width()-1){
      $rotated->[$x][$y] = $matrix->[$y][$x];
    }
  }

  my @output;
  for my $col (@$rotated){
    push @output, join '', @$col;
  }

  $self->{rotated} = \@output;
}

}
1;
