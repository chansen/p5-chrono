#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Time');
}

{
    my $t = Chrono::Time->new(
        hour        => 12,
        minute      => 30,
        second      => 45,
        microsecond => 123456
    );

    is($t->hour,                12, '->hour');
    is($t->minute,              30, '->minute');
    is($t->second,              45, '->second');
    is($t->millisecond,        123, '->millisecond');
    is($t->microsecond,     123456, '->microsecond');

    is($t->to_string,       '12:30:45.123456',  '->to_string');
    is($t->to_string(6),    '12:30:45.123456',  '->to_string(6)');
    is($t->to_string(5),    '12:30:45.12345',   '->to_string(5)');
    is($t->to_string(4),    '12:30:45.1234',    '->to_string(4)');
    is($t->to_string(3),    '12:30:45.123',     '->to_string(3)');
    is($t->to_string(2),    '12:30:45.12',      '->to_string(2)');
    is($t->to_string(1),    '12:30:45.1',       '->to_string(1)');
    is($t->to_string(0),    '12:30:45',         '->to_string(0)');
    is("$t",                '12:30:45.123456',  'stringification');
}

done_testing();

