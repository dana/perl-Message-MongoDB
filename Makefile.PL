use 5.006;
use strict;
use warnings FATAL => 'all';
use inc::Module::Install;

name     'Message-MongoDB';
all_from 'lib/Message/MongoDB.pm';
author   q{Dana M. Diederich <diederich@gmail.com>};
license  'artistic2';

perl_version 5.006;

tests_recursive('t');

resources (
   #IRC        => 'irc://irc.perl.org/#Message-MongoDB',
   homepage   => 'https://metacpan.org/module/Message::MongoDB',
   license    => 'http://www.perlfoundation.org/artistic_license_2_0',
   repository => 'git://github.com/dana/perl-Message-MongoDB.git',
   bugtracker => 'https://github.com/dana/perl-Message-MongoDB/issues',
);

configure_requires (
    'Module::Install' => 0,
);

build_requires (
    'Test::More' => 0,
    'MongoDB' => 0,
);

requires (
    'MongoDB' => 0,
);

install_as_cpan;
auto_install;
WriteAll;
