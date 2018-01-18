# scibian/vcs -*- perl -*-
#
# Copyright © 2017 Scibian Project <legal@scibian.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, you can find it on the World Wide
# Web at http://www.gnu.org/copyleft/gpl.html, or write to the Free
# Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
# MA 02110-1301, USA.

package Lintian::scibian::vcs;

use strict;
use warnings;

use Lintian::Tags qw(tag);

sub run {
    my ($pkg, undef, $info) = @_;

    my $vcs_git = $info->field('vcs-git');
    my $vcs_browser = $info->field('vcs-browser');

    if (not defined($vcs_git) or not defined($vcs_browser)) {
        tag 'scibian-vcs-missing';
    } else {
        my $url_root = 'https://github.com/scibian/';
        if ($vcs_git !~ /^${url_root}.*$/ or $vcs_browser !~ /^${url_root}.*$/) {
            tag 'scibian-vcs-not-org';
        } else {
            if ($vcs_git !~ /^${url_root}${pkg}.git$/ or $vcs_browser !~ /^${url_root}${pkg}$/) {
              tag 'scibian-vcs-not-src-name';
            }
        }
    }

    return;
}

1;
