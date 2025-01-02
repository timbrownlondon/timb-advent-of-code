package Trail;
use strict;
use lib '.';
use Node;
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
    my @chars = map {0+$_} split '', $line;
    die 'line lengths are not uniform' unless @chars == $self->width();
    push @collector, \@chars;
  }
  Node->set_grid( \@collector );
  $self->{grid} = \@collector;
}


sub value_of {
  my ($self, $point) = @_;

  $self->grid()->[$point->[1]]->[$point->[0]];
}


sub start_nodes {
  my $self = shift;

  return $self->{start_nodes} if $self->{start_nodes};

  my @nodes;
  for my $y (0..$self->height() -1){
    for my $x (0..$self->width() -1){
      push @nodes, Node->new($x,$y) if $self->grid()->[$y][$x] == 0;
    }
  }
  $self->{start_nodes} = \@nodes;
}

# all paths starting at a zero
# but not necessarily complete (reaching 9)
sub find_paths {
  my $self = shift;

  return $self->{paths} if $self->{paths};

  for my $node ( @{$self->start_nodes()} ){
    $self->find_children($node);
  }
  $self->{paths} = $self->start_nodes();
}


sub path_count {
  my $self = shift;
  $self->{complete_paths};
}

sub find_children {
  my ($self, $node) = @_;

  if ($node->val() == 9){
    # we have found a complete path
    $self->{complete_paths}++;
    return;
  }
  for my $candidate ( @{$self->points_to_consider($node)} ){
  # print join ', ', $candidate->x(), $candidate->y(), $candidate->val(), "\n";
    if ($candidate->val() == $node->val() + 1){
      $node->add_child($candidate);
    # $candidate->parent($node);
      $self->find_children($candidate);
    }
  }
}

sub dedupe_paths {
  my $self = shift;

  for my $node ( @{$self->start_nodes()} ){
    

  }
}




sub points_to_consider {
  my ($self, $node) = @_;

  #return posints N,S,E,W of this point
  # if they are on the grid
  # we assume that the given point is on the grid
  
  my @array;
  push @array, Node->new($node->x()-1,$node->y()) if $node->x() > 0;
  push @array, Node->new($node->x()+1,$node->y()) if $node->x() < $self->width() -1;
  push @array, Node->new($node->x(),$node->y()-1) if $node->y() > 0;
  push @array, Node->new($node->x(),$node->y()+1) if $node->y() < $self->height() -1;
  \@array;
}

sub show {
  my $self = shift;

  for my $y (0..$self->height() -1){
    for my $x (0..$self->width() -1){
      print $self->grid()->[$y][$x], '-';
    }
    print "\n";
  }
}

sub show_nodes {
  my $self = shift;

  for my $node ( @{$self->start_nodes()} ){
    print $node->path('');
  }
}



1;
