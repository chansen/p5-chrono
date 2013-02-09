#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Time');
}

{
    my $t1 = Chrono::Time->from_hms(0, 30, 45, 123456);
    for my $hours (0..23) {
        my $t2 = Chrono::Time->from_hms($hours, 30, 45, 123456);
        {
            is($t2->delta_hours($t1),  $hours, "+$hours hours");
            is($t1->delta_hours($t2), -$hours, "-$hours hours");
        }
        {
            my $minutes = $hours * 60;
            is($t2->delta_minutes($t1),  $minutes, "+$minutes minutes");
            is($t1->delta_minutes($t2), -$minutes, "-$minutes minutes");
        }
        {
            my $seconds = $hours * 60 * 60;
            is($t2->delta_seconds($t1),  $seconds, "+$seconds seconds");
            is($t1->delta_seconds($t2), -$seconds, "-$seconds seconds");
        }
        {
            my $usec = $hours * 60 * 60 * 1000_000;
            is($t2->delta_microseconds($t1),  $usec, "+$usec microseconds");
            is($t1->delta_microseconds($t2), -$usec, "-$usec microseconds");
        }
    }
}

done_testing;

