package t::Util;
use strict;
use warnings;

BEGIN {
    our @EXPORT_OK = qw(
        leap_year
        days_in_year
        days_in_quarter
        days_in_month
    );

    require Exporter;
    *import = \&Exporter::import;
}

#                       Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
my $DaysInMonth365 = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
#                        Q1  Q2  Q3  Q4
my $DaysInQuarter  = [0, 90, 91, 92, 92];

sub leap_year {
    my ($y) = @_;
    return $y % 4 == 0 && ($y % 100 != 0 || $y % 400 == 0);
}

sub days_in_year {
    my ($y) = @_;
    return 365 + leap_year($y);
}

sub days_in_quarter {
    my ($y, $q) = @_;
    return $DaysInQuarter->[$q] + ($q == 1 && leap_year($y));
}

sub days_in_month {
    my ($y, $m) = @_;
    return $DaysInMonth365->[$m] + ($m == 2 && leap_year($y));
}

1;

