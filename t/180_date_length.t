#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Date');
}

{
    my $d = Chrono::Date->from_ymd(2012, 1, 1);
    is($d->length_of_year, 366, "length of leap year is 366");
    is($d->is_leap_year,   !!1, "leap year returns true");
}

{
    my $d = Chrono::Date->from_ymd(2013, 1, 1);
    is($d->length_of_year, 365, "length of common year is 365");
    is($d->is_leap_year,   !!0, "leap year returns false");
}

{
                       #  Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    my @MonthLength366 = (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    my $month = 0;
    foreach my $length (@MonthLength366) {
        my $d = Chrono::Date->from_ymd(2012, ++$month, 1);
        is($d->length_of_month, $length, "length of month $month is $length in a leap year");
    }
}

{
                       #  Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    my @MonthLength365 = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    my $month = 0;
    foreach my $length (@MonthLength365) {
        my $d = Chrono::Date->from_ymd(2013, ++$month, 1);
        is($d->length_of_month, $length, "length of month $month is $length in a common year");
    }
}

{
                         #  Q1  Q2  Q3  Q4
    my @QuarterLength366 = (91, 91, 92, 92);
    my $quarter = 0;
    foreach my $length (@QuarterLength366) {
        my $d = Chrono::Date->from_yqd(2012, ++$quarter, 1);
        is($d->length_of_quarter, $length, "length of quarter $quarter is $length in a leap year");
    }
}

{
                         #  Q1  Q2  Q3  Q4
    my @QuarterLength365 = (90, 91, 92, 92);
    my $quarter = 0;
    foreach my $length (@QuarterLength365) {
        my $d = Chrono::Date->from_yqd(2013, ++$quarter, 1);
        is($d->length_of_quarter, $length, "length of quarter $quarter is $length in a common year");
    }
}

done_testing;

