use Test::More tests => 9;
use lib '.';
use Data::Dumper;
use_ok Diskfragmenter;
use strict;

{
  my $str = '2333133121414131402';
  my $DF = Diskfragmenter->new_from_string( $str );

  isa_ok( $DF, 'Diskfragmenter' );

  is_deeply( $DF->make_array_for(3,4), [4,4,4], 'make_array_for(3,4) is [4,4,4]' );
  is_deeply( $DF->make_array_for(3,0), [0,0,0], 'make_array_for(3,0) is [0,0,0]' );
  is_deeply( $DF->make_array_for(2), [undef,undef,], 'make_array_for(2,0) is [undef,undef]' );

  is_deeply( $DF->expanded(),
  [0,0,undef,undef,undef,1,1,1,undef,undef,undef,2,undef,undef,undef,3,3,3,undef,4,4,undef,5,5,5,5,undef,6,6,6,6,undef,7,7,7,undef,8,8,8,8,9,9],
  'expanded()');


  $DF->move_blocks_forward();
  is_deeply( $DF->expanded(),
  [0,0,9,9,8,1,1,1,8,8,8,2,7,7,7,3,3,3,6,4,4,6,5,5,5,5,6,6,undef,undef,undef,undef,undef,undef,undef,undef,undef,undef,undef,undef,undef,undef],
  'expanded() result has been updated after move_blocks_forward()');

  is ( $DF->checksum_part1(), 1928, 'checksum_part1() is 1928' );

  $DF->move_files_forward();

  is ( $DF->checksum_part2(), 2858, 'checksum_part2() is 2858' );

  #print Dumper $DF->files();
}

