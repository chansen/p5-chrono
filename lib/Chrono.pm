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

#  Coercion
#  Chrono::DateTime  -> Chrono::Date     (XS)
#  Chrono::DateTime  -> Chrono::Time     (XS)
#  Chrono::DateTime <-> Chrono::DateTime
#  DateTime          -> Chrono::Date
#  DateTime          -> Chrono::Time
#  DateTime         <-> Chrono::DateTime

sub DateTime::__as_Chrono_Date {
    my ($dt) = @_;
    my ($rdn) = $dt->local_rd_values;
    return Chrono::Date->from_rdn($rdn);
}

sub DateTime::__as_Chrono_Time {
    my ($dt) = @_;
    return Chrono::Time->from_hms($dt->hour, $dt->minute, $dt->second, $dt->microsecond);
}

sub DateTime::__as_Chrono_DateTime {
    my ($dt) = @_;
    my ($rdn, $second_of_day, $nsec) = $dt->local_rd_values;
    my $epoch = ($rdn - 719163) * 86400 + $second_of_day;
    return Chrono::DateTime->from_epoch($epoch, int($nsec / 1000));
}

sub Chrono::DateTime::__as_DateTime {
    my ($c) = @_;
    return DateTime->from_object(object => $c)->set_time_zone('floating');
}

1;

