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
        my $from = "->from_ymd(2012, $month, 1)->at_end_of_month";
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
        my $from = "->from_yqd(2012, $quarter, 1)->at_end_of_quarter";
        is($date->year,               2013, "$from->year");
        is($date->quarter,        $quarter, "$from->quarter");
        is($date->day_of_quarter,     $day, "$from->day_of_quarter");
    }
}

done_testing;

