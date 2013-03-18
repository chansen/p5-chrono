#!perl

use strict;
use warnings;

use Benchmark     qw[];
use Chrono        qw[];
use DateTime      qw[];

{
    print "Benchmarking constructor: ->new(year, month, day, hour, minute, second)\n";
    my $zone = DateTime::TimeZone->new(name => 'floating');
    Benchmark::cmpthese( -10, {
        'Chrono::DateTime' => sub {
            my $cd = Chrono::DateTime->new(
                year   => 2012,
                month  => 12,
                day    => 25,
                hour   => 12,
                minute => 30,
                second => 30
            );
        },
        'DateTime' => sub {
            my $dt = DateTime->new(
                year   => 2012,
                month  => 12,
                day    => 25,
                hour   => 12,
                minute => 30,
                second => 30
            );
        },
        'DateTime w/ zone' => sub {
            my $dt = DateTime->new(
                year      => 2012,
                month     => 12,
                day       => 25,
                hour      => 12,
                minute    => 30,
                second    => 30,
                time_zone => $zone
            );
        },
    });
}

{
    print "\n\nBenchmarking constructor: ->from_epoch\n";
    my $time = time;
    my $zone = DateTime::TimeZone->new(name => 'floating');
    Benchmark::cmpthese( -10, {
        'Chrono::DateTime' => sub {
            my $cd = Chrono::DateTime->from_epoch($time)
        },
        'DateTime' => sub {
            my $dt = DateTime->from_epoch(epoch => $time);
        },
        'DateTime w/ zone' => sub {
            my $dt = DateTime->from_epoch(epoch => $time, time_zone => $zone);
        },
    });
}

{
    print "\n\nBenchmarking accessor: ->year\n";
    my $cd = Chrono::DateTime->new(year => 2012);
    my $dt = DateTime->new(year => 2011);
    Benchmark::cmpthese( -10, {
        'Chrono::DateTime' => sub {
            my $y = $cd->year;
        },
        'DateTime' => sub {
            my $y = $dt->year;
        },
    });
}

{
    print "\n\nBenchmarking set/with: day\n";
    my $cd = Chrono::DateTime->new(year => 2012);
    my $dt = DateTime->new(year => 2012);
    Benchmark::cmpthese( -10, {
        'Chrono::DateTime' => sub {
            $cd = $cd->with_day(1);
        },
        'DateTime' => sub {
            $dt->set_day(1);
        },
    });
}

{
    print "\n\nBenchmarking set/with: year, month, day\n";
    my $cd = Chrono::DateTime->new(year => 2012);
    my $dt = DateTime->new(year => 2012);
    Benchmark::cmpthese( -10, {
        'Chrono::DateTime' => sub {
            $cd = $cd->with_year(2020)
                     ->with_month(12)
                     ->with_day(24);
        },
        'DateTime' => sub {
            $dt->set(year => 2020, month => 12, day => 24);
        },
    });
}

{
    print "\n\nBenchmarking arithmetic: ->subtract_datetime\n";
    my $c1 = Chrono::DateTime->new(year => 2012);
    my $c2 = Chrono::DateTime->new(year => 2013);
    my $d1 = DateTime->new(year => 2012);
    my $d2 = DateTime->new(year => 2013);
    Benchmark::cmpthese( -10, {
        'Chrono::DateTime' => sub {
            my $dur = $c1->minus_datetime($c2);
        },
        'DateTime' => sub {
            my $dur = $d1->subtract_datetime_absolute($d2);
        },
    });
}

{
    print "\n\nBenchmarking arithmetic: +7 days -7 days\n";
    my $cd = Chrono::DateTime->new(year => 2012);
    my $dt = DateTime->new(year => 2012);
    Benchmark::cmpthese( -10, {
        'Chrono::DateTime' => sub {
            $cd = $cd->plus_days(7)->plus_days(-7);
        },
        'DateTime' => sub {
            $dt->add(days => 7)->subtract(days => 7);
        },
    });
}

{
    print "\n\nBenchmarking arithmetic: +1 week -1 week using Duration object\n";
    my $cdt = Chrono::DateTime->new(year => 2012);
    my $cdd = Chrono::Duration->from_days(7);
    my $dt = DateTime->new(year => 2012);
    my $dd = DateTime::Duration->new(days => 7);
    Benchmark::cmpthese( -10, {
        'Chrono::DateTime' => sub {
            $cdt = $cdt->plus_duration($cdd)->minus_duration($cdd);
        },
        'DateTime' => sub {
            $dt->add_duration($dd)->subtract_duration($dd);
        },
    });
}

{
    print "\n\nBenchmarking sort: 1000 dates with time\n";

    my @epochs = map { 
        int(rand(365.2425 * 50) * 86400 + rand(86400))
    } (1..1000);

    my @cd = map {
        Chrono::DateTime->from_epoch($_)
    } @epochs;

    my @dt = map {
        DateTime->from_epoch(epoch => $_, time_zone => 'floating')
    } @epochs;

    {
        Benchmark::cmpthese( -10, {
            'Chrono::DateTime' => sub {
                my @dates = sort { $a->compare($b) } @cd;
            },
            'DateTime' => sub {
                my @dates = sort { $a->compare($b) } @dt;
            },
        });
    }
}

