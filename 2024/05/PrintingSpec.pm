package PrintingSpec {
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
    push @rules, [$1, $2];
  }
  \@rules;
}

sub parse_updates {
  my ($class, $updates_array) = @_;

  my @updates;
  for my $line (@$updates_array){
    my @items = split /,/, $line;
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

}
1;
