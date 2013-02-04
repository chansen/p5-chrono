package Chrono;
use strict;
use warnings;

BEGIN {
    our $VERSION = '0.01';
    require XSLoader; XSLoader::load(__PACKAGE__, $VERSION);
    require Chrono::Date;
    require Chrono::Time;
    require Chrono::DateTime;
    require Chrono::Duration;
}

1;

