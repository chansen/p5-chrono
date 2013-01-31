#!/usr/bin/perl
use strict;
use warnings;

use Chrono::Date;
use Chrono::Time;
use Chrono::DateTime;
use Chrono::Duration;
use DateTime;

use Devel::Size qw[total_size];

printf "Chrono::Date .............. : %4d B\n", total_size(Chrono::Date->new);
printf "Chrono::Time  ............. : %4d B\n", total_size(Chrono::Time->new);
printf "Chrono::DateTime .......... : %4d B\n", total_size(Chrono::DateTime->new);
printf "Chrono::Duration .......... : %4d B\n", total_size(Chrono::Duration->new);
printf "DateTime .................. : %4d B\n", total_size(DateTime->now);
printf "DateTime w/o zone and locale: %4d B\n", total_size do {
    my $dt = DateTime->now; delete @{$dt}{qw(time_zone locale)}; $dt;
};
printf "DateTime::Duration ........ : %4d B\n", total_size(DateTime::Duration->new);

