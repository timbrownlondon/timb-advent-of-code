package Ingredients;
use strict;
use Data::Dumper;

sub new {
  my ($class, @text) = @_;

  # remove trailing newlines (and anyother whitespace)
  map {s/\s//g} @text;

  my $self;
  $self->{text} = \@text;

  my $i = 1;
  my @lines;
  for (@text){
    last if m/^$/;
    $i++;
    m/(\d+)-(\d+)/ or die "unexpected format for $_\n";
    push @lines, [$1,$2];
  }

  $self->{ranges} = \@lines;
  $self->{seperator_index} = $i;

  my @slice = @text[$i .. $#text];
  $self->{ids} = \@slice;

  bless $self, $class;
}

sub ids {
  my $self = shift;
  return $self->{ids};
}

sub ranges {
  my $self = shift;
  return $self->{ranges};
}

sub is_fresh {
  my ($self, $id) = @_;

  for my $limit (@{$self->ranges()}){
    # warn "   $id between ",$limit->[0], ' and ', $limit->[1], "\n";
    return 1 if $id >= $limit->[0] and $id <= $limit->[1];
  }
  return 0;
}


1;
