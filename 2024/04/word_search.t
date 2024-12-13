use Test::More tests => 10;
use lib '.';
use Data::Dumper;

use_ok WordSearch;

{
  my $WS = WordSearch->new(['_TIM_TIM','___TIM__']);
  is($WS->count_matches('TIM'), 3, 'count_matches()');
}

{
  my $WS = WordSearch->new(['abcde','fghij','klmno','pqrst','uvwxy']);
  my $expected = ['afkpu','bglqv','chmrw','dinsx','ejoty'];

  is_deeply($WS->rotated($lines), $expected, 'rotated() 5x5');
}

{
  my $WS = WordSearch->new(['abc','def','ghi','jkl']);

  is($WS->width(), 3, 'width()');
  is($WS->height(), 4, 'height()');

  is_deeply($WS->as_matrix(), [['a','b','c'], ['d','e','f'], ['g','h','i'], ['j','k','l']], 'as_matrix()');

  is_deeply($WS->right_diagonals(), ['aei', 'bf', 'c', 'dhl', 'gk', 'j'],'right_diagonals()');
  is_deeply($WS->left_diagonals(),  ['a', 'db', 'gec', 'jhf', 'ki', 'l'],'left_diagonals()');

  my $expected = ['adgj','behk','cfil'];
  is_deeply($WS->rotated(), $expected, 'rotated() 4x3');
}

{
  my $WS = WordSearch->new(['T__','I_T','M_I','__M']);
  
  is($WS->count_matches_on_rotated('TIM'), 2, 'count_matches_on_rotated()');
}
