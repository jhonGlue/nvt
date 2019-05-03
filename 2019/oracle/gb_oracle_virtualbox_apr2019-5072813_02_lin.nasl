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

CPE = "cpe:/a:oracle:vm_virtualbox";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.814799");
  script_version("2019-05-03T08:55:39+0000");
  script_cve_id("CVE-2019-2656", "CVE-2019-2657", "CVE-2019-2574", "CVE-2019-2721",
                "CVE-2019-2722", "CVE-2019-2723", "CVE-2019-2690", "CVE-2019-2679",
                "CVE-2019-2678", "CVE-2019-2703", "CVE-2019-2696", "CVE-2019-2680");
  script_tag(name:"cvss_base", value:"4.6");
  script_tag(name:"cvss_base_vector", value:"AV:L/AC:L/Au:N/C:P/I:P/A:P");
  script_tag(name:"last_modification", value:"2019-05-03 08:55:39 +0000 (Fri, 03 May 2019)");
  script_tag(name:"creation_date", value:"2019-04-18 13:17:52 +0530 (Thu, 18 Apr 2019)");
  script_name("Oracle VirtualBox Security Updates (apr2019-5072813) 02 - Linux");

  script_tag(name:"summary", value:"The host is installed with Oracle VM
  VirtualBox and is prone to multiple vulnerabilities.");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is
  present on the target host.");

  script_tag(name:"insight", value:"Multiple flaws exists due to multiple
  unspecified vulnerabilities in the core of Oracle VirtualBox");

  script_tag(name:"impact", value:"Successful exploitation of this
  vulnerability will allow a local attacker to have an impact on
  confidentiality, integrity and availability");

  script_tag(name:"affected", value:"VirtualBox versions prior to 5.2.28 and
  6.x prior to 6.0.6 on Linux.");

  script_tag(name:"solution", value:"Upgrade to Oracle VirtualBox 5.2.28 or
  6.0.6 or later. Please see the references for more information.");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"executable_version");
  script_xref(name:"URL", value:"https://www.oracle.com/technetwork/security-advisory/cpuapr2019-5072813.html#AppendixOVIR");
  script_xref(name:"URL", value:"https://www.virtualbox.org");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2019 Greenbone Networks GmbH");
  script_family("General");
  script_dependencies("secpod_sun_virtualbox_detect_lin.nasl");
  script_mandatory_keys("Sun/VirtualBox/Lin/Ver");
  exit(0);
}


include("host_details.inc");
include("version_func.inc");

if(!infos = get_app_version_and_location(cpe:CPE, exit_no_version:TRUE)) exit(0);
virtualVer = infos['version'];
path = infos['location'];

if(virtualVer =~ "^6\." && version_is_less(version:virtualVer, test_version:"6.0.6")){
  fix = "6.0.6";
} else if (version_is_less(version:virtualVer, test_version:"5.2.28")){
  fix = "5.2.28";
}

if(fix)
{
  report = report_fixed_ver( installed_version:virtualVer, fixed_version:fix);
  security_message(data:report);
  exit(0);
}
