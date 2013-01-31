package Chrono::DateTime;
use strict;
use warnings;

BEGIN {
    our $VERSION = '0.01';
    require Chrono;
    *day      = \&day_of_month;
    *with_day = \&with_day_of_month;
}

1;

