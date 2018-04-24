# scibian/version -*- perl -*-
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

package Lintian::scibian::version;

use strict;
use warnings;

use Lintian::Tags qw(tag);

sub run {
    my ($pkg, undef, $info) = @_;

    # scibian specific native packages are free to have any version number
    if ($pkg =~ /^scibian-/ and $info->native) {
        return;
    }

    my $version = $info->field('version');
    if ($version !~ /.*\dsci\d+(\+[a-z]+[\d.]+)?u\d+$/) {
        tag 'scibian-version-invalid';
    }

    my %entry = $info->changelog()->parse()->dpkg();
    my $distribution = $entry{Distribution};
    my ($release,$aspect) = $distribution =~ /scibian(\d+)(\+[a-z]+[\d.]+)?/;
    # In case of wrong distribution, $release may be undefined. In this case
    # error is raised by another check.
    if (defined($release)) {
        if (not $version =~ /.*sci${release}(\+[a-z]+[\d.]+)?u\d+$/) {
            tag 'scibian-version-not-conform-distribution';
        }
    }
    if (defined($aspect)) {
        $aspect = "\\".$aspect; # protect initial + with backslash
        if (not $version =~ /.*sci\d+${aspect}u\d+$/) {
            tag 'scibian-aspect-version-not-conform-aspect-distribution';
        }
    }
    return;
}

1;
