package Direction;
use strict;
use Data::Dumper;

my @values = qw (left up right down);

my @chars = qw ( ↑ ↓ → ← );

my $next = { left => 'up',
             up => 'right',
             right => 'down',
             down => 'left' };

my $x = { left => -1,
          up => 0,
          right => 1,
          down => 0 };

my $y = { left => 0,
          up => -1,
          right => 0,
          down => 1 };

sub new {
  my ($class, $direction) = @_;

  die "expecting @values" unless
    $direction eq $values[0] or
    $direction eq $values[1] or
    $direction eq $values[2] or
    $direction eq $values[3];

  my $self;
  $self->{direction} = $direction; 

  bless $self, $class;
}

sub turn_right {
   my $self = shift;

   $self->{direction} = $next->{ $self->{direction} };

   $self->char();
}

sub char {
   my $self = shift;

   return  '↑' if $self->{direction} eq 'up';
   return  '↓' if $self->{direction} eq 'down';
   return  '→' if $self->{direction} eq 'right';
   return  '←' if $self->{direction} eq 'left';
   die 'direction should be  one of left, right, up, down';
}

sub is_visited_char {
  my ($class, $char) = @_;

  $char eq $chars[0] or
  $char eq $chars[1] or
  $char eq $chars[2] or
  $char eq $chars[3];
}

sub x_move {
   my $self = shift;
   $x->{$self->{direction}};
}

sub y_move {
   my $self = shift;
   $y->{$self->{direction}};
}

1;
