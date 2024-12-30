package Diskfragmenter;
use strict;
use Data::Dumper;

sub new_from_string{
  my ($class, $str) = @_;

  my $self;
  $self->{string} = $str;
  bless $self, $class;
}

sub reset {
  my $self = shift;

  $self->{expanded} = undef;
}

sub expanded {
  my $self = shift;

  return $self->{expanded} if $self->{expanded};

  my @expanded;
  my $i = 0;
  for my $ch ( split '', $self->{string} ){
    ++$i % 2 ?
      push @expanded, @{ $self->make_array_for( 0 + $ch, int($i/2) ) } :
      push @expanded, @{ $self->make_array_for( 0 + $ch ) };
  }
  $self->{expanded} = \@expanded;
}

sub make_array_for {
  my ($class, $length, $id) = @_;
  
  my @blocks;
  while ($length-- > 0){
    push @blocks, $id;
  }
  \@blocks;
}

sub files {
  my $self = shift;

  return $self->{files} if $self->{files};

  my @files;
  my $i = 0;
  my $pointer = 0;
  for my $ch ( split '', $self->{string} ){
    ++$i % 2 ?
      push @files, { id => int($i/2), length => 0 + $ch, start => $pointer } :
      push @files, { length => 0 + $ch, start => $pointer };
      $pointer += $ch;
  }
  $self->{files} = \@files;
}

sub move_blocks_forward {
  my $self = shift;

  my $end_pointer = @{$self->expanded()} - 1;
  my $start_pointer = 0;

  while ( 1 ) {

    while ( ! defined $self->expanded()->[$end_pointer] ){ $end_pointer-- }
    while ( defined $self->expanded()->[$start_pointer] ){ $start_pointer++ }

#   print "Start: $start_pointer ", $self->expanded()->[$start_pointer], "\n";
#   print "End $end_pointer ", $self->expanded()->[$end_pointer], "\n";

    last if $start_pointer > $end_pointer;

    # swap items
    $self->expanded()->[$start_pointer] = $self->expanded()->[$end_pointer];
    $self->expanded()->[$end_pointer] = undef;

    $end_pointer--;
    $start_pointer++;
  }
  $self->expanded();
}

sub move_files_forward {
  my $self = shift;

  my $items = @{$self->files()};
  my $i = 0;
  while ( 1 ) {
    # find next space (spaces don't have an id)
    my $index_of_space = 0;
    while ( defined $self->files()->[$index_of_space]->{id} ){ $index_of_space++ }
    my $space = $self->files()->[$index_of_space];
    my $file  = $self->find_file_to_fit($space);

    if ($file) {
      print "$i: moving id ", $file->{id}, "\n";
      $file->{moved} = 1;
      $file->{start} = $space->{start};
      $space->{length} = $space->{length} - $file->{length};
      $space->{start} = $space->{start} + $file->{length};

      $self->tidy_files_array();
    }
    last if $i++ > $items;
  }
}

# working from the end of the files array
# is there a file that fits $length?
sub find_file_to_fit {
  my  ($self, $space) = @_;

  for my $file ( reverse @{$self->{files}}){
    next unless defined $file->{id};
    return 0 if $space->{start} > $file->{start};
    return $file if $file->{length} <= $space->{length};
  }
  0;
}

sub tidy_files_array {
  my $self = shift;

  # remove any elements that have length zero
  # (these should be spaces that have now been filled)
  my @ordered = sort { $a->{start} <=> $b->{start} } grep {$_->{length}} @{$self->{files}};
  $self->{files} = \@ordered;
}

sub checksum_part1 {
  my $self = shift;

  my $total = 0;
  
  for my $i (0 .. @{$self->expanded()} -1 ){
    $total += $i * $self->expanded()->[$i];
  }
  $total;
}

sub checksum_part2 {
  my $self = shift;

  my $total = 0;
  
  for my $file (@{$self->{files}}){
    next unless defined $file->{id}; # ignore spaces
    for my $i ($file->{start} .. $file->{start} + $file->{length} - 1){
      $total += $i * $file->{id};
    }
  }
  $total;
}

1;
