###############################################################################
# OpenVAS Vulnerability Test
#
# Apple iCloud Security Updates(HT208853)
#
# Authors:
# Rajat Mishra <rajatm@secpod.com>
#
# Copyright:
# Copyright (C) 2018 Greenbone Networks GmbH, http://www.greenbone.net
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################
CPE = "cpe:/a:apple:icloud";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.813514");
  script_version("2019-05-03T08:55:39+0000");
  script_cve_id("CVE-2018-4224", "CVE-2018-4225", "CVE-2018-4226", "CVE-2018-4232",
                "CVE-2018-4192", "CVE-2018-4214", "CVE-2018-4204", "CVE-2018-4246",
                "CVE-2018-4200", "CVE-2018-4201", "CVE-2018-4218", "CVE-2018-4233",
                "CVE-2018-4188", "CVE-2018-4190", "CVE-2018-4199", "CVE-2018-4222");
  script_tag(name:"cvss_base", value:"6.8");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:P/I:P/A:P");
  script_tag(name:"last_modification", value:"2019-05-03 08:55:39 +0000 (Fri, 03 May 2019)");
  script_tag(name:"creation_date", value:"2018-06-06 11:24:10 +0530 (Wed, 06 Jun 2018)");
  script_name("Apple iCloud Security Updates(HT208853)");

  script_tag(name:"summary", value:"This host is installed with Apple iCloud
  and is prone to multiple vulnerabilities.");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is present on the target host.");

  script_tag(name:"insight", value:"The multiple flaws exists due to,

  - An authorization issue in state management.

  - A permissions issue in the handling of web browser cookies.

  - A race condition issue in locking.

  - A memory corruption issue in input validation.

  - A type confusion issue in memory handling.

  - A memory corruption issue in state management.

  - Multiple memory corruption issues in memory handling.

  - An inconsistent user interface issue in state management.

  - A buffer overflow issue in memory handling.

  - An out-of-bounds read issue in input validation.");

  script_tag(name:"impact", value:"Successful exploitation will allow an
  attacker to read a persistent device identifier, modify the state of the
  Keychain, view sensitive user information, overwrite cookies, execute arbitrary
  code, crash Safari, spoof address bar and leak sensitive data.");

  script_tag(name:"affected", value:"Apple iCloud versions before 7.5");

  script_tag(name:"solution", value:"Upgrade to Apple iCloud 7.5 or later. Please see the references for more information.");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"registry");
  script_xref(name:"URL", value:"https://support.apple.com/en-us/HT208853");
  script_xref(name:"URL", value:"http://www.apple.com");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2018 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("gb_apple_icloud_detect_win.nasl");
  script_mandatory_keys("apple/icloud/Win/Ver");
  exit(0);
}

include("version_func.inc");
include("host_details.inc");

infos = get_app_version_and_location(cpe:CPE, exit_no_version:TRUE);
icVer = infos['version'];
iPath = infos['location'];

if(version_is_less(version:icVer, test_version:"7.5"))
{
  report = report_fixed_ver(installed_version:icVer, fixed_version:"7.5", install_path:iPath);
  security_message(data:report);
  exit(0);
}
exit(0);
