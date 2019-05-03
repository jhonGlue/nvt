###############################################################################
# OpenVAS Vulnerability Test
#
# Microsoft Office 2013 Service Pack 1 Remote Code Execution Vulnerability (KB3172522)
#
# Authors:
# Antu Sanadi <santu@secpod.com>
#
# Copyright:
# Copyright (C) 2019 Greenbone Networks GmbH, http://www.greenbone.net
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.814597");
  script_version("2019-05-03T08:55:39+0000");
  script_cve_id("CVE-2019-0541");
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"2019-05-03 08:55:39 +0000 (Fri, 03 May 2019)");
  script_tag(name:"creation_date", value:"2019-01-09 15:35:33 +0530 (Wed, 09 Jan 2019)");
  script_name("Microsoft Office 2013 Service Pack 1 Remote Code Execution Vulnerability (KB3172522)");

  script_tag(name:"summary", value:"This host is missing an important security
  update according to Microsoft KB3172522");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is present on the target host.");

  script_tag(name:"insight", value:"The flaw exists in the way that the
  MSHTML engine improperly validates input.");

  script_tag(name:"impact", value:"Successful exploitation will allow an attacker
  to execute arbitrary code in the context of the current user.");

  script_tag(name:"affected", value:"Microsoft Office 2013 Service Pack 1");

  script_tag(name:"solution", value:"The vendor has released updates. Please see the references for more information.");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"executable_version");
  script_xref(name:"URL", value:"https://support.microsoft.com/en-us/help/3172522");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2019 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("secpod_office_products_version_900032.nasl");
  script_mandatory_keys("MS/Office/Ver");
  script_require_ports(139, 445);
  exit(0);
}


include("smb_nt.inc");
include("host_details.inc");
include("version_func.inc");
include("secpod_smb_func.inc");

pptVer = get_kb_item("MS/Office/Ver");
path = registry_get_sz(key:"SOFTWARE\Microsoft\Windows\CurrentVersion",
                          item:"ProgramFilesDir");
if(!path){
  exit(0);
}

offPath = path + "\Microsoft Office\OFFICE15" ;
exeVer  = fetch_file_version(sysPath:offPath, file_name:"msohev.dll");
if(!exeVer){
  exit(0);
}

if(exeVer =~ "^15\." && version_is_less(version:exeVer, test_version:"15.0.5101.1000"))
{
  report = report_fixed_ver(file_checked:offPath + "\msohev.dll	",
                            file_version:exeVer, vulnerable_range:"15.0 - 15.0.5101.0999");
  security_message(data:report);
}
exit(99);
