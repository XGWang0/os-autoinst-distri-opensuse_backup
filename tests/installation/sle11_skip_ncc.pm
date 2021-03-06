# SUSE's openQA tests
#
# Copyright © 2009-2013 Bernhard M. Wiedemann
# Copyright © 2012-2016 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

# G-Summary: prepare some more tests for sle11
# G-Maintainer: Stephan Kulow <coolo@suse.de>

use base "y2logsstep";
use strict;
use testapi;

sub run() {
    my $self = shift;

    assert_screen 'novell-customer-center', 30;

    # configure later
    send_key "alt-c";

    sleep 1;
    send_key $cmd{next};
}

1;
