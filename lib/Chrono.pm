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

use Carp qw[];
sub Chrono::Duration::to_string {
    @_ == 1 || Carp::croak(q/Usage: $datetime->to_string()/);
    my ($self) = @_;
    return sprintf 'PTS%f', $self->total_seconds;
}

{
    my @UNITS = qw(year month day hour minute second);
    sub Chrono::DateTime::to_datetime {
        @_ == 1 || @_ == 2 || Carp::croak(q/Usage: $datetime->to_datetime([time_zone])/);
        my ($self, $time_zone) = @_;

        my %params; 
           @params{@UNITS}     = map { $self->$_ } @UNITS;
           $params{nanosecond} = $self->microsecond * 1000;
           $params{time_zone}  = $time_zone if defined $time_zone;
        require DateTime; return DateTime->new(%params);
    }
}

1;

__END__

