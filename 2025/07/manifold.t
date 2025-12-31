use Test::More; 
use lib '.';
use Data::Dumper;
use_ok Manifold;
use strict;

open my $IN, '<', 'test-input' or die $!;
my $M= Manifold->new(<$IN>);
close $IN;

isa_ok($M, 'Manifold');

is($M->height(), 15, 'height() OK');
is($M->width(), 14, 'width() OK');

ok($M->is_char_at('.',0,0), 'is_char_at() OK');
ok(! $M->is_pipe_at(0,0), 'is_pipe_at() OK');
ok($M->set_pipe_at(0,0), 'set_pipe_at() OK');
ok($M->is_pipe_at(0,0), 'is_pipe_at() OK');

is($M->S_column(), 7, 'S_column() OK');
ok($M->is_carat_at(14,1), 'is_carat_at() OK');
ok(! $M->is_carat_at(0,0), 'is_carat_at() OK');

is($M->split_count(), 21, 'split_count() OK');

# warn Dumper $M;
$M->print_matrix();

done_testing();
