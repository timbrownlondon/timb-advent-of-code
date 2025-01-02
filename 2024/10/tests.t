use Test::More tests => 9;
use lib '.';
use Data::Dumper;
use_ok Trail;
use_ok Node;
use strict;

my $grid = <<ENDSTR;
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
ENDSTR

my $T = Trail->new_from_string($grid);

is( $T->width(), 8, 'width() is 8' );
is( $T->height(), 8, 'height() is 8' );

is( $T->value_of([0,3]), 9, 'value_of([0,3] is 9' );
is( $T->value_of([9,9]), undef, 'value_of([9,9] is undef' );
is( $T->value_of([-1,-1]), undef, 'value_of([-1,-1] is undef' );

Node->set_grid( $T->grid() );

is ( Node->new(0,0)->val(), 8, 'Node->new(0,0)->val() is 8' );
is ( Node->new(1,5)->val(), 2, 'Node->new(1,5)->val() is 2' );

$T->find_paths();
print $T->path_count(), "\n";

$T->show_nodes();
