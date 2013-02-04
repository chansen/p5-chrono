#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::DateTime');
}

{
    my $dt = Chrono::DateTime->new(
        year        => 2012,
        month       => 12,
        day         => 24,
        hour        => 12,
        minute      => 30,
        second      => 45,
        microsecond => 123456
    );

    is($dt->year,              2012, '->year');
    is($dt->quarter,              4, '->quarter');
    is($dt->month,               12, '->month');
    is($dt->week,                52, '->week');

    is($dt->day_of_year,        359, '->day_of_year');
    is($dt->day_of_quarter,      85, '->day_of_quarter');
    is($dt->day_of_month,        24, '->day_of_month');
    is($dt->day_of_week,          1, '->day_of_week');

    is($dt->hour,                12, '->hour');
    is($dt->minute,              30, '->minute');
    is($dt->second,              45, '->second');
    is($dt->millisecond,        123, '->millisecond');
    is($dt->microsecond,     123456, '->microsecond');

    is($dt->epoch,       1356352245, '->epoch');

    is($dt->cjdn,           2456286, '->cjdn');
    is($dt->rdn,             734861, '->rdn');
    
    isa_ok($dt->date, 'Chrono::Date', '->date');
    isa_ok($dt->time, 'Chrono::Time', '->time');
    
    is($dt->date->to_string,      '2012-12-24', '->date->to_string');
    is($dt->time->to_string, '12:30:45.123456', '->time->to_string');
    
    is($dt->to_string,      '2012-12-24T12:30:45.123456',   '->to_string');
    is($dt->to_string(6),   '2012-12-24T12:30:45.123456',   '->to_string(6)');
    is($dt->to_string(5),   '2012-12-24T12:30:45.12345',    '->to_string(5)');
    is($dt->to_string(4),   '2012-12-24T12:30:45.1234',     '->to_string(4)');
    is($dt->to_string(3),   '2012-12-24T12:30:45.123',      '->to_string(3)');
    is($dt->to_string(2),   '2012-12-24T12:30:45.12',       '->to_string(2)');
    is($dt->to_string(1),   '2012-12-24T12:30:45.1',        '->to_string(1)');
    is($dt->to_string(0),   '2012-12-24T12:30:45',          '->to_string(0)');
    is("$dt",               '2012-12-24T12:30:45.123456',   'stringification');

    is($dt->local_rd_as_seconds,    63492035445, '->local_rd_as_seconds');
    is($dt->utc_rd_as_seconds,      63492035445, '->utc_rd_as_seconds');

    is_deeply(
        [ $dt->local_rd_values ],
        [ 734861, 45045, 123456000 ],
        '->local_rd_values'
    );

    is_deeply(
        [ $dt->utc_rd_values ],
        [ 734861, 45045, 123456000 ],
        '->utc_rd_values'
    );
}

done_testing();

