#!/usr/bin/env perl

use strict;
use Data::Dumper;

my @all_hands;
my $hands;

my $call_order = {
    five_kind  => 7,
    four_kind  => 6,
    full_house => 5,
    three_kind => 4,
    two_pair   => 3,
    one_pair   => 2,
    high_card  => 1,
};

my $card_order = {
    'A' => 14,
    'K' => 13,
    'Q' => 12,
    'J' => 11,
    'T' => 10,
    '9' => 9,
    '8' => 8,
    '7' => 7,
    '6' => 6,
    '5' => 5,
    '4' => 4,
    '3' => 3,
    '2' => 2
};

# parse the input
while(<>){
    m/(\w{5}) (\d+)/ or die "failed to parse:$_";
    die $_, ' seen already' if $hands->{$1};

    my $this_hand = create_hand_object($1, $2);
    push @all_hands, $this_hand;
    $hands->{$1} = $this_hand;
}

my $sum = 0;
my $rank = 1;

# sort the hands from lowest to highest value
# and calculate sum of rank x bid
for my $hand ( sort has_higher_rank @all_hands ){
    $sum += $rank++ * $hand->{bid};
}
print "Grand total: $sum\n";

sub create_hand_object {
    my $hand = shift;
    my $bid = shift;
    
    my $obj = {hand => $hand, bid => $bid};

    my $digest = digest_for($hand);
    $obj->{digest} = $digest;

    my $count_string = counts_for($digest);
    $obj->{counts} = $count_string;
  
    if ( $count_string eq '5' ){
        $obj->{call} = 'five_kind';
    }
    elsif ( $count_string eq '4-1' ){
        $obj->{call} = 'four_kind';
    }
    elsif ( $count_string eq '3-2' ){
           $obj->{call} = 'full_house';
    }
    elsif ( $count_string eq '3-1-1' ){
           $obj->{call} = 'three_kind';
    }
    elsif ( $count_string eq '2-2-1' ){
           $obj->{call} = 'two_pair';
    }
    elsif ( $count_string eq '2-1-1-1' ){
           $obj->{call} = 'one_pair';
    }
    elsif ( $count_string eq '1-1-1-1-1' ){
           $obj->{call} = 'high_card';
    }
    return $obj;
}

sub digest_for {
    my $hand = shift;
    my $digest;

    for my $ch (split '', $hand){
        $digest->{$ch}++;
    }
    return $digest;
}

sub counts_for {
    my $digest = shift;

    join '-', reverse sort values %$digest;
}

sub has_higher_rank {
    my $call_a = $a->{call};
    my $call_b = $b->{call};

       return is_better_hand( $a->{hand}, $b->{hand} ) if $call_a eq $call_b;
        
    return $call_order->{$call_a} <=> $call_order->{$call_b};
}

sub is_better_hand {
    my $string1 = shift;
    my $string2 = shift;

    for my $i (0..4){
        my $char_a = substr($string1, $i, 1);
        my $char_b = substr($string2, $i, 1);

        next if $card_order->{$char_a} == $card_order->{$char_b};
        return $card_order->{$char_a} <=> $card_order->{$char_b};
    }
    die "oops! is_better_hand can't tell between $string1 and $string2";    
}
