# SUSE's openQA tests
#
# Copyright © 2009-2013 Bernhard M. Wiedemann
# Copyright © 2012-2016 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

# Summary: Case#1436079: Firefox: Password Management
# Maintainer: wnereiz <wnereiz@gmail.com>

use strict;
use base "x11regressiontest";
use testapi;

sub run() {
    my ($self) = @_;

    mouse_hide(1);

    my $masterpw = "firefox_test";
    my $mozlogin = "http://www-archive.mozilla.org/quality/browser/front-end/testcases/wallet/login.html";

    # Clean and Start Firefox
    x11_start_program("xterm -e \"killall -9 firefox;rm -rf .moz*\"\n");
    x11_start_program("firefox");
    assert_screen('firefox-gnome', 90);

    sleep 2;
    send_key "alt-e";
    send_key "n";
    assert_and_click('firefox-passwd-security');

    sleep 1;
    send_key "alt-shift-u";

    assert_screen('firefox-passwd-master_setting', 30);

    type_string $masterpw;
    send_key "tab";
    type_string $masterpw;
    for my $i (1 .. 3) { sleep 1; send_key "ret"; }

    #Restart firefox
    sleep 1;
    send_key "ctrl-q";
    sleep 3;
    x11_start_program("firefox");
    assert_screen('firefox-gnome', 60);

    send_key "esc";
    send_key "alt-d";
    sleep 1;
    type_string $mozlogin. "\n";

    assert_and_click('firefox-passwd-input_username');
    type_string "squiddy";
    send_key "tab";
    type_string "calamari";
    send_key "ret";
    sleep 2;
    assert_and_click('firefox-passwd-confirm_remember');
    assert_screen('firefox-passwd-confirm_master_pw', 30);
    type_string $masterpw. "\n";

    sleep 1;
    send_key "esc";
    send_key "alt-d";
    type_string $mozlogin. "\n";
    assert_screen('firefox-passwd-auto_filled', 90);

    sleep 1;
    send_key "alt-e";
    send_key "n";    #Preferences
    sleep 1;
    assert_and_click('firefox-passwd-security');
    send_key "alt-shift-p";    #"Saved Passwords..."
    sleep 1;
    send_key "alt-shift-p";    #"Show Passwords"
    sleep 1;
    type_string $masterpw. "\n";
    sleep 1;
    assert_screen('firefox-passwd-saved', 30);

    sleep 1;
    send_key "alt-shift-r";    #"Remove"
    sleep 1;
    send_key "alt-shift-c";
    sleep 1;
    send_key "ctrl-w";
    sleep 1;
    send_key "f5";
    assert_screen('firefox-passwd-input_username', 90);

    # Exit
    send_key "alt-f4";

    if (check_screen('firefox-save-and-quit', 30)) {
        # confirm "save&quit"
        send_key "ret";
    }
}
1;
# vim: set sw=4 et:
