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
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA


CPE = "cpe:/a:google:chrome";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.815701");
  script_version("2019-09-27T07:41:55+0000");
  script_cve_id("CVE-2019-13685", "CVE-2019-13688", "CVE-2019-13687", "CVE-2019-13686");
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"2019-09-27 07:41:55 +0000 (Fri, 27 Sep 2019)");
  script_tag(name:"creation_date", value:"2019-09-25 19:11:56 +0530 (Wed, 25 Sep 2019)");
  script_name("Google Chrome Security Updates(stable-channel-update-for-desktop_18-2019-09)-Linux");

  script_tag(name:"summary", value:"The host is installed with Google Chrome
  and is prone to multiple vulnerabilities.");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is present
  on the target host.");

  script_tag(name:"insight", value:"Multiple flaws exist due to

  - A use-after-free issue in UI.

  - A use-after-free issue in media.

  - A use-after-free issue in offline pages.");

  script_tag(name:"impact", value:"Successful exploitation will allow
  an unprivileged attacker to remotely execute code, leak sensitive data
  or cause denial of service condition.");

  script_tag(name:"affected", value:"Google Chrome version prior to 77.0.3865.90 on Linux");

  script_tag(name:"solution", value:"Upgrade to Google Chrome version
  77.0.3865.90 or later. Please see the references for more information.");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"executable_version");
  script_xref(name:"URL", value:"https://chromereleases.googleblog.com/2019/09/stable-channel-update-for-desktop_18.html");
  script_xref(name:"URL", value:"https://www.google.com/chrome");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2019 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_google_chrome_detect_lin.nasl");
  script_mandatory_keys("Google-Chrome/Linux/Ver");
  exit(0);
}


include("host_details.inc");
include("version_func.inc");

if(!nesPort = get_app_port(cpe:CPE)){
  exit(0);
}

if(!infos = get_app_version_and_location(cpe:CPE, port:nesPort, exit_no_version:TRUE)) exit(0);
chr_ver = infos['version'];
chr_path = infos['location'];

if(version_is_less(version:chr_ver, test_version:"77.0.3865.90"))
{
  report = report_fixed_ver(installed_version:chr_ver, fixed_version:"77.0.3865.90", install_path:chr_path);
  security_message(data:report);
  exit(0);
}
exit(99);
