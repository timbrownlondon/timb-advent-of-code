package WordSearch {
use Data::Dumper;

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

sub count_matches_on_diagonals{
  my ($self, $match_string) = @_;
  my $count = 0;

  for my $line (@{$self->right_diagonals()}){
    my @found = ($line =~ m/$match_string/g);
    $count += scalar @found;
  }
  for my $line (@{$self->left_diagonals()}){
    my @found = ($line =~ m/$match_string/g);
    $count += scalar @found;
  }
  return $count; 
}

sub count_X_MAS{
  my $self = shift;

  my $count = 0;
  for my $position (@{$self->coordinates_of_A()}){
      $count++ if $self->is_center_of_X_MAS($position);
  }  
  return $count;
}

sub is_center_of_X_MAS{
  my ($self, $position) = @_;

  # e.g
  # M.S
  # .A.
  # M.S
  
  my ($x,$y) = @$position;
  my $one = $self->concatenate_cells([$x-1,$y-1],[$x,$y],[$x+1,$y+1]);
  my $two = $self->concatenate_cells([$x+1,$y-1],[$x,$y],[$x-1,$y+1]);

  return 1 if (($one eq 'MAS' or $one eq 'SAM') and ($two eq 'MAS' or $two eq 'SAM'));
  return 0;
}

sub value_at{
  my ($self, $x, $y) = @_;

  $self->as_matrix()->[$y][$x];
}

sub concatenate_cells{
  my ($self, @cells) = @_;

  my $str = '';
  for my $position (@cells){
    $str .= $self->value_at($position->[0], $position->[1]);
  }
  return $str;
}

sub coordinates_of_A{
  my $self = shift;
 
  return $self->{coordinates_of_A} if $self->{coordinates_of_A};

  # we don't need to search the edge of the matrix, hence 1..height-2
  for my $y (1..$self->height()-2){
    for my $x (1..$self->width()-2){
#     print $self->as_matrix()->[$y][$x], "----\n";
      push @coords, [$x,$y] if $self->as_matrix()->[$y][$x] eq 'A';
    }
  }

  $self->{coordinates_of_A} = \@coords;
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

sub populate_diagonals{
  my ($self, $expr) = @_;

  my $max_x_index = $self->width() - 1;
  my $max_y_index = $self->height() - 1;

  my $collector_hash;
  for my $x (0..$max_x_index){
    for my $y (0..$max_y_index){
      my $cell_value = $self->as_matrix->[$y][$x];
      push @{$collector_hash->{eval $expr}}, $cell_value;
    }
  }
  my @collector_array;
  for my $set (values %$collector_hash){
    push @collector_array, join '', @$set;
  }
  my @output = sort {$a cmp $b} @collector_array;

  return \@output;
}

sub right_diagonals{
  my $self = shift;

  unless ($self->{right_diagonals}){
    $self->{right_diagonals} = $self->populate_diagonals('$x-$y') 
  }
  return $self->{right_diagonals};
}

sub left_diagonals{
  my $self = shift;

  unless ($self->{left_diagonals}){
    $self->{left_diagonals} = $self->populate_diagonals('$x+$y') 
  }
  return $self->{left_diagonals};
}

}
1;
