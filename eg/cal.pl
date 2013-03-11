#!/usr/bin/perl
use strict;
use warnings;

use Chrono::Date;
use Getopt::Long;

my ($Year, $Month, $FirstDay, @DoW, @MoY);

($Year, $Month) = ( localtime() )[ 5, 4 ];
$Year  += 1900;
$Month += 1;

@MoY      = qw(January February March     April   May      June
               July    August   September October November December);
@DoW      = qw(Mo Tu We Th Fr Sa Su);
$FirstDay = 1; # Monday;

Getopt::Long::GetOptions(
    'y|year=i'      => \$Year,
    'm|month=i'     => \$Month,
    'd|first_day=i' => \$FirstDay,
    'l|locale=s'    => sub {
        require DateTime::Locale;
        my $locale = DateTime::Locale->load($_[1]);
        @MoY       = @{ $locale->month_format_wide };
        @DoW       = map { " $_" } @{ $locale->day_stand_alone_narrow };
        $FirstDay  = $locale->first_day_of_week;
        binmode STDOUT, ':utf8';
    }
);

sub calendar_month {
    my ($date, $first_day_of_week) = @_;

    $first_day_of_week ||= 1; # Monday

    my $cur = $date->at_start_of_month
                   ->at_start_of_week($first_day_of_week);
    my $end = $date->at_end_of_month
                   ->at_end_of_week($first_day_of_week);

    my @weeks;
    while ($cur < $end) {
        push @weeks, [ map { $cur->add_days($_) } ( 0..6 ) ];
        $cur = $cur->add_weeks(1);
    }
    return wantarray ? @weeks : \@weeks;
}

my $date  = Chrono::Date->from_ymd($Year, $Month, 1);
my @weeks = calendar_month($date, $FirstDay);
my @order = map  { $_->[0] }
            sort { $a->[1] <=> $b->[1] }
            map  { [ $_ - 1, ($_ - $FirstDay) % 7 ] } ( 1..7 );

printf "    %s %.4d\n", ucfirst $MoY[$date->month - 1], $date->year;
printf "%s\n", join ' ', map { $DoW[$_] } @order;
foreach my $week (@weeks) {
    printf "%s\n", join ' ', map {
        $_->month == $Month
          ? sprintf '%2d', $_->day_of_month
          : '  '
    } @$week;
}

