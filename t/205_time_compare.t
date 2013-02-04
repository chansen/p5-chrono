#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Time');
}

{
    my $t1 = Chrono::Time->new(
        hour        => 12,
        minute      => 30,
        second      => 45,
        microsecond => 123456
    );

    my $t2 = Chrono::Time->new(
        hour        => 23,
        minute      => 30,
        second      => 45,
        microsecond => 123456
    );
    
    is($t1->is_before($t2), !!1, "$t1 is before $t2");
    is($t1->is_after($t2),  !!0, "$t1 is not after $t2");
    is($t1->is_equal($t2),  !!0, "$t1 is not equal $t2");
    
    is($t2->is_before($t1), !!0, "$t2 is not before $t1");
    is($t2->is_after($t1),  !!1, "$t2 is after $t1");
    is($t2->is_equal($t1),  !!0, "$t2 is not equal $t1");
    
    is($t1->is_equal($t1),  !!1, "$t1 is equal $t1");
    is($t2->is_equal($t2),  !!1, "$t2 is equal $t2");
    
    cmp_ok($t1->compare($t2), '<',  0, "$t1 ->compare $t2");
    cmp_ok($t2->compare($t1), '>',  0, "$t2 ->compare $t1");
    cmp_ok($t1->compare($t1), '==', 0, "$t1 ->compare $t1");
    cmp_ok($t2->compare($t2), '==', 0, "$t2 ->compare $t2");
    
    cmp_ok($t1, '!=', $t2, "$t1 != $t2");
    cmp_ok($t1,  '<', $t2, "$t1  < $t2");
    cmp_ok($t1, '<=', $t2, "$t1 <= $t2");
    cmp_ok($t1, '==', $t1, "$t1 == $t1");
    
    cmp_ok($t2, '!=', $t1, "$t2 != $t1");
    cmp_ok($t2,  '>', $t1, "$t2  > $t1");
    cmp_ok($t2, '>=', $t1, "$t2 >= $t1");
    cmp_ok($t2, '==', $t2, "$t2 == $t2");
    
    my $s1 = '12:30:45.123456';
    my $s2 = '23:30:45.123456';
    cmp_ok($t2, 'ne', $s1, "$t2 ne $s1");
    cmp_ok($t2, 'gt', $s1, "$t2 gt $s1");
    cmp_ok($t2, 'ge', $s1, "$t2 ge $s1");
    cmp_ok($t2, 'eq', $s2, "$t2 eq $s2");
}

done_testing();

