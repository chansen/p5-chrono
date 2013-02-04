#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::DateTime');
}

{
    my $d1 = Chrono::Duration->new(
        days         => 1,
        hours        => 24,
        minutes      => 1440,
        seconds      => 86400,
        microseconds => 123456
    );

    my $d2 = Chrono::Duration->new(
        days         => 2,
        hours        => 24,
        minutes      => 1440,
        seconds      => 86400,
        microseconds => 123456
    );

    cmp_ok($d1->compare($d2), '<',  0, "$d1 ->compare $d2");
    cmp_ok($d2->compare($d1), '>',  0, "$d2 ->compare $d1");
    cmp_ok($d1->compare($d1), '==', 0, "$d1 ->compare $d1");
    cmp_ok($d2->compare($d2), '==', 0, "$d2 ->compare $d2");
    
    cmp_ok($d1, '!=', $d2, "$d1 != $d2");
    cmp_ok($d1,  '<', $d2, "$d1  < $d2");
    cmp_ok($d1, '<=', $d2, "$d1 <= $d2");
    cmp_ok($d1, '==', $d1, "$d1 == $d1");
    
    cmp_ok($d2, '!=', $d1, "$d2 != $d1");
    cmp_ok($d2,  '>', $d1, "$d2  > $d1");
    cmp_ok($d2, '>=', $d1, "$d2 >= $d1");
    cmp_ok($d2, '==', $d2, "$d2 == $d2");
}

done_testing();

