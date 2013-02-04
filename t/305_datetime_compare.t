#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::DateTime');
}

{
    my $dt1 = Chrono::DateTime->new(
        year        => 2012,
        month       => 12,
        day         => 24,
        hour        => 12,
        minute      => 30,
        second      => 45,
        microsecond => 123456
    );

    my $dt2 = Chrono::DateTime->new(
        year        => 2012,
        month       => 12,
        day         => 24,
        hour        => 23,
        minute      => 30,
        second      => 45,
        microsecond => 123456
    );
    
    is($dt1->is_before($dt2), !!1, "$dt1 is before $dt2");
    is($dt1->is_after($dt2),  !!0, "$dt1 is not after $dt2");
    is($dt1->is_equal($dt2),  !!0, "$dt1 is not equal $dt2");
    
    is($dt2->is_before($dt1), !!0, "$dt2 is not before $dt1");
    is($dt2->is_after($dt1),  !!1, "$dt2 is after $dt1");
    is($dt2->is_equal($dt1),  !!0, "$dt2 is not equal $dt1");
    
    is($dt1->is_equal($dt1),  !!1, "$dt1 is equal $dt1");
    is($dt2->is_equal($dt2),  !!1, "$dt2 is equal $dt2");
    
    cmp_ok($dt1->compare($dt2), '<',  0, "$dt1 ->compare $dt2");
    cmp_ok($dt2->compare($dt1), '>',  0, "$dt2 ->compare $dt1");
    cmp_ok($dt1->compare($dt1), '==', 0, "$dt1 ->compare $dt1");
    cmp_ok($dt2->compare($dt2), '==', 0, "$dt2 ->compare $dt2");
    
    cmp_ok($dt1, '!=', $dt2, "$dt1 != $dt2");
    cmp_ok($dt1,  '<', $dt2, "$dt1  < $dt2");
    cmp_ok($dt1, '<=', $dt2, "$dt1 <= $dt2");
    cmp_ok($dt1, '==', $dt1, "$dt1 == $dt1");
    
    cmp_ok($dt2, '!=', $dt1, "$dt2 != $dt1");
    cmp_ok($dt2,  '>', $dt1, "$dt2  > $dt1");
    cmp_ok($dt2, '>=', $dt1, "$dt2 >= $dt1");
    cmp_ok($dt2, '==', $dt2, "$dt2 == $dt2");
    
    my $s1 = '2012-12-24T12:30:45.123456';
    my $s2 = '2012-12-24T23:30:45.123456';
    cmp_ok($dt2, 'ne', $s1, "$dt2 ne $s1");
    cmp_ok($dt2, 'gt', $s1, "$dt2 gt $s1");
    cmp_ok($dt2, 'ge', $s1, "$dt2 ge $s1");
    cmp_ok($dt2, 'eq', $s2, "$dt2 eq $s2");
}

done_testing();

