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
  script_oid("1.3.6.1.4.1.25623.1.0.876322");
  script_version("2019-05-14T05:04:40+0000");
  script_cve_id("CVE-2019-3900", "CVE-2019-9503", "CVE-2019-9500", "CVE-2019-3882",
                "CVE-2019-9857", "CVE-2019-8980", "CVE-2019-8912", "CVE-2019-7221",
                "CVE-2019-6974", "CVE-2019-7222", "CVE-2018-16880", "CVE-2019-3459",
                "CVE-2019-3460", "CVE-2019-3701", "CVE-2018-19406", "CVE-2018-19824",
                "CVE-2018-16862", "CVE-2018-19407", "CVE-2018-18710", "CVE-2018-14633",
                "CVE-2018-17182", "CVE-2018-5391", "CVE-2018-15471", "CVE-2018-3620",
                "CVE-2018-3646", "CVE-2018-14734", "CVE-2018-14678", "CVE-2018-13405",
                "CVE-2018-13053", "CVE-2018-12896", "CVE-2018-13093", "CVE-2018-13094",
                "CVE-2018-13095", "CVE-2018-12714", "CVE-2018-12633", "CVE-2018-12232",
                "CVE-2018-10853", "CVE-2018-11506", "CVE-2018-10840", "CVE-2018-3639",
                "CVE-2018-1120", "CVE-2018-10322", "CVE-2018-10323", "CVE-2018-1108");
  script_tag(name:"cvss_base", value:"10.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"2019-05-14 05:04:40 +0000 (Tue, 14 May 2019)");
  script_tag(name:"creation_date", value:"2019-05-08 02:10:09 +0000 (Wed, 08 May 2019)");
  script_name("Fedora Update for kernel FEDORA-2019-a6cd583a8d");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2019 Greenbone Networks GmbH");
  script_family("Fedora Local Security Checks");
  script_dependencies("gather-package-list.nasl");
  script_mandatory_keys("ssh/login/fedora", "ssh/login/rpms", re:"ssh/login/release=FC28");

  script_xref(name:"FEDORA", value:"2019-a6cd583a8d");
  script_xref(name:"URL", value:"https://lists.fedoraproject.org/archives/list/package-announce%40lists.fedoraproject.org/message/RI3WXXM5URTZSR3RVEKO6MDXDFIKTZ5R");

  script_tag(name:"summary", value:"The remote host is missing an update for the
  'kernel' package(s) announced via the FEDORA-2019-a6cd583a8d advisory.");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable package version is
  present on the target host.");

  script_tag(name:"insight", value:"The kernel meta package");

  script_tag(name:"affected", value:"'kernel' package(s) on Fedora 28.");

  script_tag(name:"solution", value:"Please install the updated package(s).");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"package");

  exit(0);
}

include("revisions-lib.inc");
include("pkg-lib-rpm.inc");

release = rpm_get_ssh_release();
if(!release)
  exit(0);

res = "";
report = "";

if(release == "FC28") {

  if(!isnull(res = isrpmvuln(pkg:"kernel", rpm:"kernel~5.0.11~100.fc28", rls:"FC28"))) {
    report += res;
  }

  if(report != "") {
    security_message(data:report);
  } else if (__pkg_match) {
    exit(99);
  }
  exit(0);
}

exit(0);
