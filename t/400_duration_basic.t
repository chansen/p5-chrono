#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Duration');
}

{
    my $d = Chrono::Duration->new(
        days         => 1,
        hours        => 24,
        minutes      => 1440,
        seconds      => 86400,
        microseconds => 123456
    );

    is($d->days,                       4, '->days');
    is($d->hours,                     96, '->hours');
    is($d->minutes,                 5760, '->minutes');
    is($d->seconds,               345600, '->seconds');
    is($d->milliseconds,       345600123, '->milliseconds');
    is($d->microseconds,    345600123456, '->microseconds');

    is($d->millisecond,              123, '->millisecond');
    is($d->microsecond,           123456, '->microsecond');

    is($d->is_zero,                  !!0, '->is_zero');
    is($d->is_positive,              !!1, '->is_positive');
    is($d->is_negative,              !!0, '->is_negative');

    is($d->to_string,       'PT345600S.123456',     '->to_string');
    is($d->to_string(6),    'PT345600S.123456',     '->to_string(6)');
    is($d->to_string(5),    'PT345600S.12345',      '->to_string(5)');
    is($d->to_string(4),    'PT345600S.1234',       '->to_string(4)');
    is($d->to_string(3),    'PT345600S.123',        '->to_string(3)');
    is($d->to_string(2),    'PT345600S.12',         '->to_string(2)');
    is($d->to_string(1),    'PT345600S.1',          '->to_string(1)');
    is($d->to_string(0),    'PT345600S',            '->to_string(0)');
    is("$d",                'PT345600S.123456',     'stringification');
}

done_testing();

