#!perl
use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Chrono::Date');
}

{
    package MyDate;

    sub new {
        my ($class, %p) = @_;
        return bless \%p, $class;
    }

    sub year  { return $_[0]->{year}  }
    sub month { return $_[0]->{month} }
    sub day   { return $_[0]->{day}   }

    sub __as_Chrono_Date {
        my ($self) = @_;
        return Chrono::Date->new(%$self);
    }
}

{
    my $object = MyDate->new(
        year  => 2012,
        month => 12,
        day   => 24
    );

    my $chrono = Chrono::Date->from_object($object);

    isa_ok($chrono, 'Chrono::Date');
    is($chrono->year,  2012, '->year');
    is($chrono->month,   12, '->month');
    is($chrono->day,     24, '->day');
}

done_testing();

