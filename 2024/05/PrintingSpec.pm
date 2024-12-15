package PrintingSpec;
use strict;
use Data::Dumper;

sub new {
  my ($class, $rules_array, $updates_array) = @_;

  my $self;
  $self->{rules} = $class->parse_rules($rules_array);
  $self->{updates} = $class->parse_updates($updates_array);

  bless $self, $class;
}

sub parse_rules {
  my ($class, $rules_array) = @_;

  my @rules;
  for my $line (@$rules_array){
    $line =~ m/(\d+)\|(\d+)/ or die "cannot parse $line";
    push @rules, [$1+0, $2+0];
  }
  \@rules;
}

sub parse_updates {
  my ($class, $updates_array) = @_;

  my @updates;
  for my $line (@$updates_array){
    my @items = map {$_+0} split /,/, $line;

    push @updates, \@items;
  }
  \@updates;
}

sub rules {
  my $self = shift;
  $self->{rules} or die 'rules have not been set';
}

sub updates {
  my $self = shift;
  $self->{updates} or die 'updates have not been set';
}

sub sum_of_middle_element_of_valid_updates {
  my $self = shift;

  my $sum = 0;

  for my $update (@{$self->updates}){
    $sum += $self->middle_element_of($update) if $self->update_is_valid($update);
  }
  return $sum;
}

sub update_is_valid {
  my ($self, $update) = @_;

  for my $rule (@{$self->rules()}){
    return 0 unless $self->update_obeys_rule($update, $rule);
  }
  return 1;
}

sub update_obeys_rule {
  my ($self, $update, $rule) = @_;

  my ($earlier, $later) = @$rule;
  my $update_as_string = join ',', @$update;

  # if both earlier and later numbers both appear then they must be ordered
  # correctly
  return 1 unless $update_as_string =~ m/$earlier/;
  return 1 unless $update_as_string =~ m/$later/;

  return $update_as_string  =~ m/${earlier}.*?${later}/;
}

sub middle_element_of {
  my ($class, $update) = @_;

  die 'even number of elements: ', @$update if (scalar @$update % 2) == 0;

  my $mid_index = (scalar @$update - 1) / 2;
  $update->[$mid_index];
}

sub invalid_updates {
  my $self = shift;

  return $self->{invalid_updates} if $self->{invalid_updates};

  my @invalid_updates;
  for my $update (@{$self->updates()}){
    push @invalid_updates, $update unless $self->update_is_valid($update);
  }
  $self->{invalid_updates} = \@invalid_updates;
}

sub make_valid_update_from {
  my ($self, $update) = @_;

  my @update_copy = @$update;

  for my $rule (@{$self->rules()}){
    $self->modify_update_for_rule(\@update_copy, $rule) unless $self->update_obeys_rule(\@update_copy, $rule);
  }
  \@update_copy;
}

sub modify_update_for_rule {
  my ($self, $update, $rule) = @_;

  return $update if $self->update_obeys_rule($update, $rule);

  my ($a, $b) = @$rule;
  my $a_position = $self->index_of($update, $a);
  my $b_position = $self->index_of($update, $b);
# print 'index of a ', $self->index_of($update, $a), "\n";
# print 'index of b ', $self->index_of($update, $b), "\n";

  $update->[$a_position] = $b;
  $update->[$b_position] = $a;
# print Dumper $rule;
# print Dumper $update;
  $update;
}

sub index_of {
  my ($class, $array, $value) = @_;

  for my $i (0.. scalar @$array - 1){
    return $i if $array->[$i] == $value;
  }
  return -1;
}

sub sum_of_middle_element_of_invalid_updates {
  my $self = shift;

  my $sum = 0;
  for my $update (@{$self->invalid_updates()}){
    $sum += $self->middle_element_of( $self->make_valid_update_from($update) );
  }
  $sum;
}
1;
