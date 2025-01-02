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

sub parent {
   my ($self, $parent) = @_;
   
   $self->{parent} = $parent;
 }



sub str {
  my ($self, $indent) = @_;

  print $indent, '(', $self->x(),',', $self->y(), ') ',  $self->val(), "\n";
  for my $child ( @{$self->{children}} ){
    $child->str( $indent . ' ' );
  }
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

1;
