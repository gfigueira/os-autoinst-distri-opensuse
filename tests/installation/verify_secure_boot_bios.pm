# SUSE's openQA tests
#
# Copyright © 2020-2021 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

# Summary: Checks Secure Boot status, before installation.
# Maintainer: QE YaST <qa-sle-yast@suse.de>

use strict;
use warnings;
use base 'y2_installbase';
use testapi;
use scheduler 'get_test_suite_data';


sub run {
    my $test_data = get_test_suite_data();
    assert_screen 'linuxrc-start-shell-before-installation', 90;
    assert_script_run("bootctl status | grep \"Secure Boot: $test_data->{secure_boot}\"");
    enter_cmd "exit";
}

1;

