#!perl
use strict;
use warnings;

use Test::More tests => 5;

BEGIN {
    use_ok('Chrono');
    use_ok('Chrono::Date');
    use_ok('Chrono::Time');
    use_ok('Chrono::DateTime');
    use_ok('Chrono::Duration');
}

diag("Chrono $Chrono::VERSION, Perl $], $^X");

