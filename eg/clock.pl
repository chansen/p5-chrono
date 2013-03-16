#!/usr/bin/perl
use strict;
use warnings;

use Chrono::DateTime;
use DateTime::TimeZone;

my @zones = qw(
    Africa/Cairo
    America/Chicago
    America/Los_Angeles
    America/New_York
    Asia/Dubai
    Asia/Hong_Kong
    Asia/Tokyo
    Australia/Sydney
    Europe/Brussels
    Europe/London
    Europe/Moscow
    Europe/Paris
    Europe/Stockholm
);

my $now = Chrono::DateTime->from_epoch(time);
my @clocks;
foreach my $name (@zones) {
    my $zone = DateTime::TimeZone->new(name => $name);
    my $dt   = $now->plus_seconds($zone->offset_for_datetime($now));
    $name =~ s/\w+\///;
    $name =~ s/_/\x20/g;
    push @clocks, [$name, $dt];
}

my @DoW = qw(Mon Tue Wed Thu Fri Sat Sun);
for my $clock (sort { $a->[1] <=> $b->[1] } @clocks) {
    my ($name, $dt) = @$clock;
    printf "%-12s %s %.2d:%.2d\n", 
      $name, $DoW[$dt->day_of_week - 1], $dt->hour, $dt->minute;
}

