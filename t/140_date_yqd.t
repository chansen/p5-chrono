#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Date');
}

while (<DATA>) {
    next if /\A \# /x;
    chomp;
    my ($y, $m, $d, $q, $doq) = split /,\s*/, $_;

    my $exp = sprintf '%.4d-%.2d-%.2d', $y, $m, $d;

    {
        my $date = Chrono::Date->from_yqd($y, $q, $doq);
        my $from = "->from_yqd($y, $q, $doq)";
        is($date->year,            $y,   "$from->year");
        is($date->month,           $m,   "$from->month");
        is($date->day_of_month,    $d,   "$from->day_of_month");
        is($date->quarter,         $q,   "$from->quarter");
        is($date->day_of_quarter,  $doq, "$from->day_of_quarter");
        is($date->to_string,       $exp, "$from->to_string");
        is_deeply([$date->to_yqd], [$y, $q, $doq], "$from->to_yqd");
    }

    {
        my $date = Chrono::Date->from_ymd($y, $m, $d);
        my $from = "->from_ymd($y, $m, $d)";
        is($date->quarter,        $q,   "$from->quarter");
        is($date->day_of_quarter, $doq, "$from->day_of_quarter");
    }
}

done_testing;

__DATA__
1974,  1, 12, 1, 12
1974,  5, 27, 2, 57
1974,  8, 26, 3, 57
1974, 10, 18, 4, 18
1975,  3, 30, 1, 89
1975,  4, 22, 2, 22
1975,  7, 22, 3, 22
1975, 12, 16, 4, 77
1980,  3,  9, 1, 69
1980,  4, 29, 2, 29
1980,  9, 29, 3, 91
1980, 10, 22, 4, 22
1992,  2, 28, 1, 59
1992,  6,  9, 2, 70
1992,  9,  1, 3, 63
1992, 12, 18, 4, 79
1994,  3,  1, 1, 60
1994,  5, 17, 2, 47
1994,  9, 10, 3, 72
1994, 12, 10, 4, 71
2027,  2, 26, 1, 57
2027,  6, 14, 2, 75
2027,  8, 26, 3, 57
2027, 10, 28, 4, 28
2036,  1, 20, 1, 20
2036,  4, 12, 2, 12
2036,  7, 16, 3, 16
2036, 11,  6, 4, 37
2055,  3,  1, 1, 60
2055,  4, 20, 2, 20
2055,  7, 26, 3, 26
2055, 10, 26, 4, 26
2066,  3,  8, 1, 67
2066,  6, 11, 2, 72
2066,  7,  4, 3,  4
2066, 12, 12, 4, 73
2077,  3,  5, 1, 64
2077,  4,  8, 2,  8
2077,  8,  5, 3, 36
2077, 10, 13, 4, 13
2105,  3, 29, 1, 88
2105,  5, 15, 2, 45
2105,  8,  1, 3, 32
2105, 10, 20, 4, 20
2116,  1,  3, 1,  3
2116,  6, 25, 2, 86
2116,  7, 28, 3, 28
2116, 11, 23, 4, 54
2116,  1, 21, 1, 21
2116,  4, 14, 2, 14
2116,  8, 20, 3, 51
2116, 11,  4, 4, 35
2121,  1, 21, 1, 21
2121,  4, 20, 2, 20
2121,  9, 10, 3, 72
2121, 10, 13, 4, 13
2129,  1, 29, 1, 29
2129,  6,  7, 2, 68
2129,  8, 13, 3, 44
2129, 12, 12, 4, 73
2133,  3,  3, 1, 62
2133,  6,  6, 2, 67
2133,  8,  4, 3, 35
2133, 12, 10, 4, 71
2136,  3, 21, 1, 81
2136,  5, 13, 2, 43
2136,  9, 16, 3, 78
2136, 12, 12, 4, 73
2147,  1, 25, 1, 25
2147,  4,  7, 2,  7
2147,  8, 29, 3, 60
2147, 12,  5, 4, 66
2150,  2, 11, 1, 42
2150,  5,  7, 2, 37
2150,  7, 16, 3, 16
2150, 12, 28, 4, 89
2152,  3,  2, 1, 62
2152,  6, 23, 2, 84
2152,  7, 19, 3, 19
2152, 12, 31, 4, 92
2154,  1,  1, 1,  1
2154,  4, 29, 2, 29
2154,  7, 21, 3, 21
2154, 11,  6, 4, 37
2157,  3,  9, 1, 68
2157,  5, 21, 2, 51
2157,  9, 27, 3, 89
2157, 10, 20, 4, 20
2162,  3, 16, 1, 75
2162,  5, 31, 2, 61
2162,  7, 12, 3, 12
2162, 12,  9, 4, 70
2198,  2,  6, 1, 37
2198,  4, 10, 2, 10
2198,  8, 12, 3, 43
2198, 11,  7, 4, 38
2199,  3,  4, 1, 63
2199,  4, 26, 2, 26
2199,  8, 30, 3, 61
2199, 11,  7, 4, 38
