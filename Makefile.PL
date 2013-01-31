use strict;
use inc::Module::Install;

name           'Chrono';
all_from       'lib/Chrono.pm';
repository     'http://github.com/chansen/p5-chrono';

requires       'Carp'        => '0';
requires       'Exporter'    => '0';
requires       'XSLoader'    => '0';

test_requires  'Test::More'  => '0.47';

cc_warnings;
cc_include_paths 'src', 'xs-src';
cc_src_paths     'src', 'xs-src';

ppport;
requires_external_cc;

WriteAll;
