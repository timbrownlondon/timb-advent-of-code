package FasterStones;

sub new_from_string {
  my ($class, $string) = @_;

  my $self;
  $self->{string} = $string;
  my $stones;
  for my $n ( map {0 + $_} split /\s+/, $string ){
    $stones->{$n}++;
  }
  $self->{stones} = $stones;
  bless $self, $class;
}

sub stones {
  my $self = shift;
  $self->{stones};
}

sub next {
  my $self = shift;

  my $next = { %{$self->{stones}} };

  while (my ($n, $count) = each %{$self->{stones}} ){
    $next->{$n} -= $count;

    if ($n eq '0'){
      $next->{'1'} += $count;
    }
    elsif (length ("$n") % 2 == 0){
      my ($a, $b) = @{FasterStones->split_number("$n")};
      $next->{"$a"} += $count;
      $next->{"$b"} += $count;
    }
    else {
      my $key = 2024 * $n;
      $next->{"$key"} += $count;
    }
  }
  
  while (my ($n, $count) = each %$next ){
    delete $next->{$n} if $count == 0;
    die "$n => $count - negative count\n" if $count < 0;
  }

  $self->{stones} = $next;
}

sub count_stones {
  my $self = shift;

  my $count = 0;
  for my $value ( values %{$self->{stones}} ) {
    $count += $value;
  }
  $count;
}

sub split_number {
  my ($class, $n) = @_;

  my $len = length $n;
  die unless $len % 2 == 0;

  [substr($n, 0, $len/2), 0 + substr($n, $len/2, $len/2)]; 
}


1;
