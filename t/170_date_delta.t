#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Date');
}

{
    my $d1 = Chrono::Date->from_ymd(1970, 1, 1);
    for my $years (0..50) {
        my $d2 = Chrono::Date->from_ymd(1970 + $years, 1, 1);
        {
            is($d1->delta_years($d2),  $years, "+$years years ");
            is($d2->delta_years($d1), -$years, "-$years years ");
        }

        {
            my $quarters = $years * 4;
            is($d1->delta_quarters($d2),  $quarters, "+$quarters quarters");
            is($d2->delta_quarters($d1), -$quarters, "-$quarters quarters");
        }

        {
            my $months = $years * 12;
            is($d1->delta_months($d2),  $months, "+$months months");
            is($d2->delta_months($d1), -$months, "-$months months");
        }
    }
}

{
    my $d1 = Chrono::Date->from_rdn(1);
    for my $days (0..500) {
        my $d2 = Chrono::Date->from_rdn(1 + $days);
        is($d1->delta_days($d2),  $days, "+$days days");
        is($d2->delta_days($d1), -$days, "-$days days");
    }
}

{
    my $d1 = Chrono::Date->from_rdn(1);
    for my $weeks (0..500) {
        my $d2 = Chrono::Date->from_rdn(1 + $weeks * 7);
        is($d1->delta_weeks($d2),  $weeks, "+$weeks weeks");
        is($d2->delta_weeks($d1), -$weeks, "-$weeks weeks");
    }
}

done_testing;

