package Farm;

sub new_from_string {
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

sub crop {
  my ($self, $x, $y) = @_;

  # not using zero offset
  # the top left cell is (1,1)
  $self->grid()->[$y-1][$x-1];
}

sub fences {
  my $self = shift;

  return $self->{fences} if $self->{fences};

  my $fences;

  for my $x (1..$self->width()){
    for my $y (1..$self->height()){
      $fences -> [$x] -> [$y] = $self->fences_for_cell($x,$y);
    }
  }
  $self->{fences} = $fences;
}

sub fences_for_cell {
  my ($self, $x, $y) = @_;

  my $this_crop = $self->crop($x,$y);

  my $fence_count = 4;

  $fence_count-- if $this_crop eq $self->crop($x+1,$y);
  $fence_count-- if $this_crop eq $self->crop($x-1,$y);
  $fence_count-- if $this_crop eq $self->crop($x,$y+1);
  $fence_count-- if $this_crop eq $self->crop($x,$y-1);

  $fence_count;
}


1;
