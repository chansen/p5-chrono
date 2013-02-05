#!perl
use strict;
use warnings;

use Test::More;
use t::Util qw[ days_in_quarter
                days_in_month ];

BEGIN {
    use_ok('Chrono::Date');
}

{
    my $date = Chrono::Date->from_ymd(1970, 1, 1);
    for my $y (1970..2020) {
        my $got = $date->with_year($y);
        is($got->year,          $y, "with_year($y)->year");
        is($got->quarter,        1, "with_year($y)->quarter");
        is($got->month,          1, "with_year($y)->month");
        is($got->day_of_year,    1, "with_year($y)->day_of_year");
        is($got->day_of_quarter, 1, "with_year($y)->day_of_quarter");
        is($got->day_of_month,   1, "with_year($y)->day_of_month");
    }
}

{
    my $date = Chrono::Date->from_ymd(2012, 2, 29);

    {
        my $got = $date->with_year(2013);
        is($got->year,         2013, "with_year(2013)->year");
        is($got->month,           2, "with_year(2013)->quarter");
        is($got->day_of_month,   28, "with_year(2013)->day_of_month");
    }

    {
        my $got = $date->with_year(2016);
        is($got->year,         2016, "with_year(2016)->year");
        is($got->month,           2, "with_year(2016)->quarter");
        is($got->day_of_month,   29, "with_year(2016)->day_of_month");
    }
}

{
    my $date = Chrono::Date->from_ymd(1970, 1, 1);
    for my $d (1..365) {
        my $got = $date->with_day_of_year($d);
        is($got->year,        1970, "with_day_of_year($d)->year");
        is($got->day_of_year,   $d, "with_day_of_year($d)->day_of_year");
    }
}

{
    my $date = Chrono::Date->from_ymd(1970, 1, 1);
    for my $m (1..12) {
        my $got = $date->with_month($m);
        is($got->year,         1970, "with_month($m)->year");
        is($got->month,          $m, "with_month($m)->month");
        is($got->day_of_month,    1, "with_month($m)->day_of_month");
    }
}

{
    my @tests = (
        [2012,  1, 28,  2, 28],
        [2012,  1, 29,  2, 29],
        [2012,  1, 30,  2, 29],
        [2012,  1, 31,  2, 29],
        [2012,  1, 31,  3, 31],
        [2012,  2, 29,  3, 29],
        [2012,  6, 30,  7, 30],
        [2012, 10, 31, 12, 31],
    );

    for my $test (@tests) {
        my ($sy, $sm, $sd, $m, $ed) = @$test;
        my $date = Chrono::Date->from_ymd($sy, $sm, $sd)->with_month($m);
        my $from = "from_ymd($sy, $sm, $sd)->with_month($m)";
        is($date->year,          $sy, "$from->year");
        is($date->month,          $m, "$from->month");
        is($date->day_of_month,  $ed, "$from->day_of_month");
    }
}

{
    for my $m (1..12) {
        my $date = Chrono::Date->from_ymd(1970, $m, 1);
        for my $d (1..days_in_month(1970, $m)) {
            my $got = $date->with_day_of_month($d);
            my $from = "with_month($m)->with_day_of_month($d)";
            is($got->year,         1970, "$from->year");
            is($got->month,          $m, "$from->month");
            is($got->day_of_month,   $d, "$from->day_of_month");
        }
    }
}

{
    my $date = Chrono::Date->from_yqd(1970, 1, 1);
    for my $q (1..4) {
        my $got = $date->with_quarter($q);
        is($got->year,           1970, "with_quarter($q)->year");
        is($got->quarter,          $q, "with_quarter($q)->quarter");
        is($got->day_of_quarter,    1, "with_quarter($q)->day_of_quarter");
    }
}

{   # my $DaysInQuarter  = [0, 90, 91, 92, 92];
    my @tests = (
        [2012, 1, 91, 2, 91],
        [2012, 2, 91, 1, 91],
        [2012, 3, 92, 1, 91],
        [2012, 1, 90, 2, 90],
        [2012, 1, 90, 3, 90],
        [2012, 1, 90, 4, 90],
    );

    for my $test (@tests) {
        my ($sy, $sq, $sd, $q, $ed) = @$test;
        my $date = Chrono::Date->from_yqd($sy, $sq, $sd)->with_quarter($q);
        my $from = "from_ymd($sy, $sq, $sd)->with_quarter($q)";
        is($date->year,            $sy, "$from->year");
        is($date->quarter,          $q, "$from->quarter");
        is($date->day_of_quarter,  $ed, "$from->day_of_quarter");
    }
}

{
    for my $q (1..4) {
        my $date = Chrono::Date->from_yqd(1970, $q, 1);
        for my $d (1..days_in_quarter(1970, $q)) {
            my $got = $date->with_day_of_quarter($d);
            my $from = "with_quarter($q)->with_day_of_quarter($d)";
            is($got->year,           1970, "$from->year");
            is($got->quarter,          $q, "$from->quarter");
            is($got->day_of_quarter,   $d, "$from->day_of_quarter");
        }
    }
}

{
    my $date = Chrono::Date->from_ywd(2010, 1, 1);
    for my $d (1..7) {
        my $got = $date->with_day_of_week($d);
        is($got->year,       2010, "with_day_of_week($d)->year");
        is($got->week,          1, "with_day_of_week($d)->week");
        is($got->day_of_week,  $d, "with_day_of_week($d)->day_of_week");
    }
}

{
    my $date = Chrono::Date->from_ywd(2010, 1, 3);
    for my $w (1..52) {
        my $got = $date->with_week($w);
        is($got->year,       2010, "with_week($w)->year");
        is($got->week,         $w, "with_week($w)->week");
        is($got->day_of_week,   3, "with_week($w)->day_of_week");
    }
}

{
    my $date = Chrono::Date->from_ywd(1970, 1, 1);
    for my $d (1..7) {
        my $got = $date->with_day_of_week($d);
        is($got->day_of_week, $d, "with_day_of_week($d)->day_of_week");
    }
}

done_testing;

