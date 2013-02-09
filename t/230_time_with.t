#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Time');
}

{
    my $time = Chrono::Time->from_hms(12, 30, 45, 123456);
    for my $hour (0..23) {
        my $got = $time->with_hour($hour);
        is($got->hour,         $hour, "with_hour($hour)->hour");
        is($got->minute,          30, "with_hour($hour)->minute");
        is($got->second,          45, "with_hour($hour)->second");
        is($got->millisecond,    123, "with_hour($hour)->millisecond");
        is($got->microsecond, 123456, "with_hour($hour)->microsecond");
    }
}

{
    my $time = Chrono::Time->from_hms(12, 30, 45, 123456);
    for my $minute (0..59) {
        my $got = $time->with_minute($minute);
        is($got->hour,             12, "with_minute($minute)->hour");
        is($got->minute,      $minute, "with_minute($minute)->minute");
        is($got->second,           45, "with_minute($minute)->second");
        is($got->millisecond,     123, "with_minute($minute)->millisecond");
        is($got->microsecond,  123456, "with_minute($minute)->microsecond");
    }
}

{
    my $time = Chrono::Time->from_hms(12, 30, 45, 123456);
    for my $second (0..59) {
        my $got = $time->with_second($second);
        is($got->hour,             12, "with_second($second)->hour");
        is($got->minute,           30, "with_second($second)->minute");
        is($got->second,      $second, "with_second($second)->second");
        is($got->millisecond,     123, "with_second($second)->millisecond");
        is($got->microsecond,  123456, "with_second($second)->microsecond");
    }
}

{
    my $time = Chrono::Time->from_hms(12, 30, 45, 123456);
    for my $usec (map { $_ * 10000 } (0..99)) {
        my $msec = int($usec / 1000);
        my $got  = $time->with_microsecond($usec);
        is($got->hour,             12, "with_microsecond($usec)->hour");
        is($got->minute,           30, "with_microsecond($usec)->minute");
        is($got->second,           45, "with_microsecond($usec)->second");
        is($got->millisecond,   $msec, "with_microsecond($usec)->millisecond");
        is($got->microsecond,   $usec, "with_microsecond($usec)->microsecond");
    }
}

done_testing;

