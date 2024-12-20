package BridgeRepair;
use strict;
use lib '.';
use Equation;
use Data::Dumper;

sub new_from_string{
  my ($class, $str) = @_;

  my @lines;
  for (split /\n/, $str){
    push @lines, Equation->new_from_string($_);
  }
  my $self;
  $self->{string} = $str;
  $self->{lines} = \@lines;

  bless $self, $class;
}

sub total{
  my $self = shift;

  my $total = 0;

  for my $eq (@{$self->{lines}}){
    $total += $eq->result() if $eq->solve();
  }
  $total;
}
1;
