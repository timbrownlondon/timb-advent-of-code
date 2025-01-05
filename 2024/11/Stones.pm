package Stones;

sub new_from_string {
  my ($class, $string) = @_;

  my $self;
  $self->{string} = $string;
  bless $self, $class;
}

sub next_string {
  my $self = shift;

  my @numbers;
  for my $n ( map {0 + $_} split /\s+/, $self->{string}) {
    if ($n == 0){
      push @numbers, 1;
    }
    elsif (length ("$n") % 2 == 0){
      push @numbers, @{Stones->split_number($n)};
    }
    else {
      push @numbers, 2024 * $n;
    }
  }
  $self->{string} = join ' ', @numbers;
}

sub count_stones {
  my $self = shift;

  scalar split /\s+/, $self->{string};
}

sub split_number {
  my ($class, $n) = @_;

  my $str = "$n";
  my $len = length $str;
  die unless $len % 2 == 0;

  [substr($str, 0, $len/2)+0, substr($str, $len/2, $len/2)+0]; 
}



1;
