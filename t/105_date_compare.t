#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Date');
}

{
    my $d1 = Chrono::Date->new(
        year  => 2012,
        month => 12,
        day   => 24
    );

    my $d2 = Chrono::Date->new(
        year  => 2013,
        month => 12,
        day   => 24
    );
    
    is($d1->is_before($d2), !!1, "$d1 is before $d2");
    is($d1->is_after($d2),  !!0, "$d1 is not after $d2");
    is($d1->is_equal($d2),  !!0, "$d1 is not equal $d2");
    
    is($d2->is_before($d1), !!0, "$d2 is not before $d1");
    is($d2->is_after($d1),  !!1, "$d2 is after $d1");
    is($d2->is_equal($d1),  !!0, "$d2 is not equal $d1");
    
    is($d1->is_equal($d1),  !!1, "$d1 is equal $d1");
    is($d2->is_equal($d2),  !!1, "$d2 is equal $d2");
    
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
    
    my $s1 = '2012-12-24';
    my $s2 = '2013-12-24';
    cmp_ok($d2, 'ne', $s1, "$d2 ne $s1");
    cmp_ok($d2, 'gt', $s1, "$d2 gt $s1");
    cmp_ok($d2, 'ge', $s1, "$d2 ge $s1");
    cmp_ok($d2, 'eq', $s2, "$d2 eq $s2");
}

done_testing();

