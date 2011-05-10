#!/usr/bin/env perl

use strict;
use warnings FATAL =>'all';
use inc::Module::Install 1.00;
all_from 'lib/Catalyst/ActionRole/MatchRequestAccepts.pm';

requires ''; ## Add project dependencies
test_requires 'Test::More' => '0.96';

require 'maint/Makefile.PL.include'
  unless -e 'META.yml';

WriteAll;
