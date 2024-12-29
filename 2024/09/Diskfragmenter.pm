package Diskfragmenter;
use strict;
use Data::Dumper;

sub new_from_string{
  my ($class, $str) = @_;

  my $self;
  $self->{string} = $str;
  bless $self, $class;
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

sub checksum {
  my $self = shift;

  my $total = 0;
  
  for my $i (0 .. @{$self->expanded()} -1 ){
    last unless defined $self->expanded()->[$i];
    $total += $i * $self->expanded()->[$i];
  }
  $total;
}

1;
