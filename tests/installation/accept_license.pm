# Copyright © 2017-2021 SUSE LLC
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
# with this program; if not, see <http://www.gnu.org/licenses/>.

# Summary: Test module is used to accept license during SLE 15 installation
# Should be improved to be more product specific.
# - Check for license-agreement
# - If INSTALLER_EXTENDED_TEST is set
#   - Check if after just pressing next, there's a warning about license not
#   being accepted
#   - Unless sles is 15+, set language to English US
# - Press next
# Maintainer: QE YaST <qa-sle-yast@suse.de>

use strict;
use warnings;
use base 'y2_installbase';
use y2_logs_helper qw(verify_license_has_to_be_accepted verify_license_translations accept_license);
use testapi;
use version_utils 'is_sle';

sub run {
    my ($self) = @_;
    assert_screen('license-agreement', 120);
    # optional checks for the extended installation
    if (get_var('INSTALLER_EXTENDED_TEST')) {
        $self->verify_license_has_to_be_accepted;
        $self->verify_license_translations;
    }
    $self->accept_license;
    send_key $cmd{next};
}

1;
