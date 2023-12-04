#!/usr/bin/env perl

use strict;
use Data::Dumper;
use List::MoreUtils qw(uniq);

my @data;
my $rows = 0;

while(<>){
	chomp;
	$data[$rows++]->{line} = $_;
}

for my $i (0..$rows-1){
	my $line = $data[$i]->{line};
	my @numbers = ($line =~ /\d+/g);
	$data[$i]->{numbers} = \@numbers;
	warn "$line has duplicate numbers" if @numbers != uniq @numbers;

	my @symbols = ($line =~ /[\#\$\%\&\*\-\/\=\@\\]/g);
	$data[$i]->{symbols} = \@symbols;
	warn "$line has duplicate symbols" if @symbols != uniq @symbols;

}	
# print Dumper \@data;
