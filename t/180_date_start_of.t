#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Date');
}

{
    my $date = Chrono::Date->from_ymd(2013, 6, 15)->at_start_of_year;
    my $from = "from_ymd(2013, 6, 15)->at_start_of_year";
    is($date->year,         2013, "$from->year");
    is($date->month,           1, "$from->month");
    is($date->day_of_month,    1, "$from->day_of_month");
    is($date->day_of_year,     1, "$from->day_of_year");
}

{
    foreach my $month (1..12) {
        my $date = Chrono::Date->from_ymd(2012, $month, 15)->at_start_of_month;
        my $from = "->from_ymd(2012, $month, 15)->at_start_of_month";
        is($date->year,            2012, "$from->year");
        is($date->month,         $month, "$from->month");
        is($date->day_of_month,       1, "$from->day_of_month");
    }
}

{
    foreach my $quarter (1..4) {
        my $date = Chrono::Date->from_yqd(2012, $quarter, 15)->at_start_of_quarter;
        my $from = "from_yqd(2012, $quarter, 15)->at_start_of_quarter";
        is($date->year,               2012, "$from->year");
        is($date->quarter,        $quarter, "$from->quarter");
        is($date->day_of_quarter,        1, "$from->day_of_quarter");
    }
}

{
    my @tests = (
        [2012, 10, 7, 1, 10, 1],
        [2012, 10, 7, 2, 10, 2],
        [2012, 10, 7, 3, 10, 3],
        [2012, 10, 7, 4, 10, 4],
        [2012, 10, 7, 5, 10, 5],
        [2012, 10, 7, 6, 10, 6],
        [2012, 10, 7, 7, 10, 7],
        [2012, 11, 1, 7, 10, 7],
        [2012, 10, 1, 1, 10, 1],
        [2012, 10, 2, 2, 10, 2],
        [2012, 10, 3, 3, 10, 3],
        [2012, 10, 4, 4, 10, 4],
        [2012, 10, 5, 5, 10, 5],
        [2012, 10, 6, 6, 10, 6],
        [2012, 10, 7, 7, 10, 7],
    );

    foreach my $test (@tests) {
        my ($sy, $sw, $sd, $day, $ew, $ed) = @$test;
        my $date = Chrono::Date->from_ywd($sy, $sw, $sd)->at_start_of_week($day);
        my $from = "->from_ywd($sy, $sw, $sd)->at_start_of_week($day)";
        is($date->week,         $ew, "$from->week");
        is($date->day_of_week,  $ed, "$from->day_of_week");
    }
}

done_testing;


