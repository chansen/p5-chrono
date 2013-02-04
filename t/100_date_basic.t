#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Date');
}

{
    my $d = Chrono::Date->new(
        year  => 2012,
        month => 12,
        day   => 24
    );

    is($d->year,               2012, '->year');
    is($d->quarter,               4, '->quarter');
    is($d->month,                12, '->month');
    is($d->week,                 52, '->week');

    is($d->day_of_year,         359, '->day_of_year');
    is($d->day_of_quarter,       85, '->day_of_quarter');
    is($d->day_of_month,         24, '->day_of_month');
    is($d->day_of_week,           1, '->day_of_week');

    is($d->cjdn,            2456286, '->cjdn');
    is($d->rdn,              734861, '->rdn');

    is($d->to_string,   '2012-12-24',   '->to_string');
    is("$d",            '2012-12-24',   'stringification');
}

done_testing();

