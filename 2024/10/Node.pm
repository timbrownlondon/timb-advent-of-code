package Node;
use strict;
use Data::Dumper;

our $grid;

sub set_grid {
  my ($class, $value) = @_;
  $grid = $value;
}

sub new {
  my ($class, $x, $y) = @_;

  my $self;
  $self->{x} = $x; 
  $self->{y} = $y; 
  $self->{val} = $grid->[$y]->[$x]; 

  bless $self, $class;
}

sub x { $_[0]->{x}; }
sub y { $_[0]->{y}; }
sub val { $_[0]->{val}; }

sub add_child {
   my ($self, $child) = @_;

   if ($self->{children} ){
     push @{$self->{children}}, $child;
   }
   else {
     $self->{children} = [$child];
   }
}

sub children {
   my $self = shift;
   
   $self->{children}  or [];
 }


sub as_string {
  my $self = shift;

   '('. $self->x().','. $self->y(). ')'. $self->val();
}

sub path {
  my ($self, $str) = @_;

  my $path = $str . '('. $self->x().','. $self->y(). ')'. $self->val();;
  for my $child ( @{$self->{children}} ){
    $child->path( $path );
  }
  warn "$path\n" if $self->val() == 9;
  return $path 
}


sub walk {
  my ($self, $str) = @_;

  $str .= $self->as_string().'=';

  print "$str\n" unless scalar @{$self->children()};

  for my $child (@{$self->children()}){
    walk($child, $str);
  }
}

sub find_nines {
  my ($self, $nines) = @_;

  push @$nines, $self if $self->val() == 9;
  for my $child (@{$self->children()}){
    $child->find_nines($nines);
  }
  return $nines;
}

1;
