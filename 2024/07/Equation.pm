package Equation;
use strict;
use Data::Dumper;

sub new_from_string {
  my ($class, $str) = @_;

  my $self;
  my ($result, @numbers) = map {0 + $_} $str =~ m/(\d+)/g;

  $self->{result} = $result;
  $self->{numbers} = \@numbers;

  bless $self, $class;
}

sub result{
  my $self = shift;
  $self->{result};
}

# returns 0 if not soluble
# return 1 if soluble
sub solve {
  my $self = shift;

  return $self->{solve} if defined $self->{solve};

  for my $expr (@{$self->expressions()}){
    my $eval = Equation->evaluate($expr);
    return $self->{solve} = 1 if $eval == $self->{result};
  }
  $self->{solve} = 0
}

sub evaluate {
  my ($class, $expression) = @_;

  my @expression = reverse @$expression;
  my $total = pop @expression;
  while (@expression){
    my $op = pop @expression;
    my $num = pop @expression;

    $total += $num if $op == 0;
    $total *= $num if $op == 1;
  }
  return $total;
}

# set of expressions that can be evaluated
# to check if they equal the target integer
sub expressions {
  my $self = shift;

  return $self->{expressions} if $self->{expressions};
  my @expressions;

  my @nums = @{$self->{numbers}};
  my @ops  = @{$self->operator_lists()};
  my $ops_count = @{$self->operator_lists()} - 1;
  my $num_count = @{$self->{numbers}} - 2;
    
  # iterate over operator lists
  for my $i (0 .. $ops_count){
    my @expr = ($nums[0]);

    for my $j (0 .. $num_count){
      push @expr, $ops[$i][$j];
      push @expr, $nums[$j+1];
    }
    push @expressions, \@expr;
  }
  $self->{expressions} = \@expressions; 
}

sub operator_lists {
  my $self = shift;

  return $self->{operator_lists} if $self->{operator_lists};

  my $length = @{$self->{numbers}} - 1;
  my $count = 2 ** $length - 1;

  my @op_lists;

  for my $i (0 .. $count){
    my @ops = map {0 + $_ } split '', sprintf "%0${length}b", $i;
    push @op_lists, \@ops;
  }
  $self->{operator_lists} = \@op_lists;
}


1;
