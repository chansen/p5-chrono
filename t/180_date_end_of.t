#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Date');
}

{
    my $date = Chrono::Date->from_ymd(2012, 1, 1)->at_end_of_year;
    my $from = "->from_ymd(2012, 1, 1)->at_end_of_year";
    is($date->year,         2012, "$from->year");
    is($date->month,          12, "$from->month");
    is($date->day_of_month,   31, "$from->day_of_month");
    is($date->day_of_year,   366, "$from->day_of_year");
}

{
    my $date = Chrono::Date->from_ymd(2013, 1, 1)->at_end_of_year;
    my $from = "->from_ymd(2013, 1, 1)->at_end_of_year";
    is($date->year,         2013, "$from->year");
    is($date->month,          12, "$from->month");
    is($date->day_of_month,   31, "$from->day_of_month");
    is($date->day_of_year,   365, "$from->day_of_year");
}

{
                       #  Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    my @MonthLength366 = (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    my $month = 0;
    foreach my $day (@MonthLength366) {
        my $date = Chrono::Date->from_ymd(2012, ++$month, 1)->at_end_of_month;
        my $from = "->from_ymd(2012, $month, 1)->at_end_of_month";
        is($date->year,            2012, "$from->year");
        is($date->month,         $month, "$from->month");
        is($date->day_of_month,    $day, "$from->day_of_month");
    }
}

{
                       #  Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    my @MonthLength365 = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    my $month = 0;
    foreach my $day (@MonthLength365) {
        my $date = Chrono::Date->from_ymd(2013, ++$month, 1)->at_end_of_month;
        my $from = "->from_ymd(2013, $month, 1)->at_end_of_month";
        is($date->year,            2013, "$from->year");
        is($date->month,         $month, "$from->month");
        is($date->day_of_month,    $day, "$from->day_of_month");
    }
}

{
                         #  Q1  Q2  Q3  Q4
    my @QuarterLength366 = (91, 91, 92, 92);
    my $quarter = 0;
    foreach my $day (@QuarterLength366) {
        my $date = Chrono::Date->from_yqd(2012, ++$quarter, 1)->at_end_of_quarter;
        my $from = "->from_yqd(2012, $quarter, 1)->at_end_of_quarter";
        is($date->year,               2012, "$from->year");
        is($date->quarter,        $quarter, "$from->quarter");
        is($date->day_of_quarter,     $day, "$from->day_of_quarter");
    }
}

{
                         #  Q1  Q2  Q3  Q4
    my @QuarterLength365 = (90, 91, 92, 92);
    my $quarter = 0;
    foreach my $day (@QuarterLength365) {
        my $date = Chrono::Date->from_yqd(2013, ++$quarter, 1)->at_end_of_quarter;
        my $from = "->from_yqd(2013, $quarter, 1)->at_end_of_quarter";
        is($date->year,               2013, "$from->year");
        is($date->quarter,        $quarter, "$from->quarter");
        is($date->day_of_quarter,     $day, "$from->day_of_quarter");
    }
}

{
    my @tests = (
        [2012, 10, 1, 1, 10, 7],
        [2012, 10, 1, 2, 10, 1],
        [2012, 10, 1, 3, 10, 2],
        [2012, 10, 1, 4, 10, 3],
        [2012, 10, 1, 5, 10, 4],
        [2012, 10, 1, 6, 10, 5],
        [2012, 10, 1, 7, 10, 6],
        [2012, 10, 1, 1, 10, 7],
        [2012, 10, 2, 2, 11, 1],
        [2012, 10, 3, 3, 11, 2],
        [2012, 10, 4, 4, 11, 3],
        [2012, 10, 5, 5, 11, 4],
        [2012, 10, 6, 6, 11, 5],
        [2012, 10, 7, 7, 11, 6],
    );
    foreach my $test (@tests) {
        my ($sy, $sw, $sd, $day, $ew, $ed) = @$test;
        my $date = Chrono::Date->from_ywd($sy, $sw, $sd)->at_end_of_week($day);
        my $from = "->from_ywd($sy, $sw, $sd)->at_end_of_week($day)";
        is($date->week,         $ew, "$from->week");
        is($date->day_of_week,  $ed, "$from->day_of_week");
    }
}

done_testing;

