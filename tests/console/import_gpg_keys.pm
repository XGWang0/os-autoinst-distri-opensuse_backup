# Copyright (C) 2015 SUSE Linux GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

# G-Summary: test to import gpg keys
#    openSUSE maintenance updates in testing are signed by a different key,
#    so that key needs to be imported manually
# G-Maintainer: Ludwig Nussel <ludwig.nussel@suse.de>

use base "consoletest";
use strict;
use testapi;

sub run() {
    select_console 'root-console';

    if (my $keys = get_var("IMPORT_GPG_KEYS")) {
        assert_script_run("rpm --import ~$username/data/$keys", timeout => 10, fail_message => 'Failed to import GPG keys');
    }
}

sub test_flags() {
    return {fatal => 1};
}

1;
# vim: set sw=4 et:
