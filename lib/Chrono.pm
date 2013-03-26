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
    my (undef, $second_of_day, $nano_of_second) = $dt->local_rd_values;
    my $microseonds = $second_of_day * 1_000_000 + int($nano_of_second / 1000);
    return Chrono::Time->midnight->plus_microseconds($microseonds);
}

sub DateTime::__as_Chrono_DateTime {
    my ($dt) = @_;
    my ($rdn, $second_of_day, $nano_of_second) = $dt->local_rd_values;
    my $epoch = ($rdn - 719163) * 86400 + $second_of_day;
    return Chrono::DateTime->from_epoch($epoch, int($nano_of_second / 1000));
}

sub Chrono::DateTime::__as_DateTime {
    my ($dt) = @_;
    return DateTime->from_object(object => $dt);
}

1;

