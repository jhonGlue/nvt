# Copyright (C) 2019 Greenbone Networks GmbH
# Text descriptions are largely excerpted from the referenced
# advisory, and are Copyright (C) the respective author(s)
#
# SPDX-License-Identifier: GPL-2.0-or-later
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.875464");
  script_version("$Revision: 13881 $");
  script_cve_id("CVE-2018-16865", "CVE-2018-16864", "CVE-2018-16866", "CVE-2018-15687",
                "CVE-2018-15686", "CVE-2018-15688");
  script_tag(name:"cvss_base", value:"5.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:P/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2019-02-26 14:01:46 +0100 (Tue, 26 Feb 2019) $");
  script_tag(name:"creation_date", value:"2019-02-18 04:07:26 +0100 (Mon, 18 Feb 2019)");
  script_name("Fedora Update for systemd FEDORA-2019-e0eb3d797e");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2019 Greenbone Networks GmbH");
  script_family("Fedora Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/fedora", "ssh/login/rpms");

  script_xref(name:"FEDORA", value:"2019-e0eb3d797e");
  script_xref(name:"URL", value:"https://lists.fedoraproject.org/archives/list/package-announce%40lists.fedoraproject.org/message/XUX2VFQ5ZOLCOLUYLW52BQYNSNQCOJKI");

  script_tag(name:"summary", value:"The remote host is missing an update for the
  'systemd' package(s) announced via the FEDORA-2019-e0eb3d797e advisory.");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable package version is
  present on the target host.");

  script_tag(name:"insight", value:"systemd is a system and service manager that
  runs as PID 1 and starts the rest of the system. It provides aggressive
  parallelization capabilities, uses socket and D-Bus activation for starting
  services, offers on-demand starting of daemons, keeps track of processes using
  Linux control groups, maintains mount and automount points, and implements an
  elaborate transactional dependency-based service control logic. systemd
  supports SysV and LSB init scripts and works as a replacement for sysvinit.
  Other parts of this package are a logging daemon, utilities to control basic
  system configuration like the hostname, date, locale, maintain a list of
  logged-in users and running containers and virtual machines, system accounts,
  runtime directories and settings, and daemons to manage simple network
  configuration, network time synchronization, log forwarding, and name resolution.
");

  script_tag(name:"affected", value:"systemd on Fedora 28.");

  script_tag(name:"solution", value:"Please install the updated package(s).");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"package");

  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-rpm.inc");

release = rpm_get_ssh_release();
if(!release) exit(0);

res = "";

if(release == "FC28")
{

  if ((res = isrpmvuln(pkg:"systemd", rpm:"systemd~238~11.gita76ee90.fc28", rls:"FC28")) != NULL)
  {
    security_message(data:res);
    exit(0);
  }

  if (__pkg_match) exit(99);
  exit(0);
}
