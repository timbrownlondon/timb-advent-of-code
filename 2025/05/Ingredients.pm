package Ingredients;
use strict;
use Data::Dumper;
use lib '.';
use Merge;

my $ranges_reduction_count = 0;

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
    m/(\d+-\d+)/ or die "unexpected format for $_\n";
    die $1 if eval $1 > 0;
    push @lines, $1;
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

  for my $r (@{$self->ranges()}){
    $r =~ m/(\d+)-(\d+)/ or die $r;
    return 1 if $id >= $1 and $id <= $2;
  }
  return 0;
}


sub find_an_overlap {
  my $self = shift;

  my $max_index = @{$self->ranges()} - 1;
  for my $i (0 .. $max_index){
    for my $j ($i+1 .. $max_index){
       my $merged = Merge->merge($self->{ranges}->[$i], $self->{ranges}->[$j]);
       if ($merged){
         # then replace i and j elements with $merged...
         $self->{ranges}->[$i] = $merged;
         delete $self->{ranges}->[$j];
         return 1;
       }
    }
  }
  return 0;
}

sub reduction_count {
  my $self = shift;
  return $ranges_reduction_count;
}

sub repeat_reduction {
  my $self = shift;
  while ($self->find_an_overlap()){
    my @deduped;
    my $seen;
    for my $item (@{$self->{ranges}}){
      next unless $item;
      next if $seen->{$item};
      $seen->{$item} = 1;
      push @deduped, $item;
    }
    $self->{ranges} = \@deduped;
  } 
}

sub count_ranges {
  my $self = shift;
  return scalar @{$self->{ranges}};
}

sub count_range_items {
  my $self = shift;

  my $count = 0;
  for my $r (@{$self->{ranges}}){
    next unless $r =~ m/(\d+)-(\d+)/;
    $count += 1 + $2 - $1;
  }
  return $count;
}

sub print_range_items {
  my $self = shift;

  my $i = 0;
  for my $item (@{$self->{ranges}}) {
    print ++$i, " $item\n";
  }
}


1;
