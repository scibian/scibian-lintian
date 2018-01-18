# scibian/distribution -*- perl -*-
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

package Lintian::scibian::distribution;

use strict;
use warnings;

use Lintian::Tags qw(tag);

sub run {
    my ($pkg, undef, $info) = @_;

    my %entry = $info->changelog()->parse()->dpkg();
    my $distribution = $entry{Distribution};
    if ($distribution eq 'UNRELEASED') {
        # ignore
    } elsif ($distribution !~ m/^scibian\d+$/) {
        tag 'scibian-wrong-distribution';
    }

    return;
}

1;