###############################################################################
# OpenVAS Vulnerability Test
#
# Microsoft Internet Explorer Multiple Vulnerabilities (3142015)
#
# Authors:
# Rinu Kuriakose <krinu@secpod.com>
#
# Copyright:
# Copyright (C) 2016 Greenbone Networks GmbH, http://www.greenbone.net
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

CPE = "cpe:/a:microsoft:ie";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.807514");
  script_version("2019-05-03T08:55:39+0000");
  script_cve_id("CVE-2016-0102", "CVE-2016-0103", "CVE-2016-0104", "CVE-2016-0105",
                "CVE-2016-0106", "CVE-2016-0107", "CVE-2016-0108", "CVE-2016-0109",
                "CVE-2016-0110", "CVE-2016-0111", "CVE-2016-0112", "CVE-2016-0113",
                "CVE-2016-0114");
  script_tag(name:"cvss_base", value:"7.6");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:H/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"2019-05-03 08:55:39 +0000 (Fri, 03 May 2019)");
  script_tag(name:"creation_date", value:"2016-03-09 09:11:13 +0530 (Wed, 09 Mar 2016)");
  script_tag(name:"qod_type", value:"executable_version");
  script_name("Microsoft Internet Explorer Multiple Vulnerabilities (3142015)");

  script_tag(name:"summary", value:"This host is missing a critical security
  update according to Microsoft Bulletin MS16-023.");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is present on the target host.");

  script_tag(name:"insight", value:"Multiple flaws exist due to,
  multiple memory corrupt errors.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attackers to execute arbitrary code, gain access to potentially sensitive
  information and gain elevated privileges on the
  affected system.");

  script_tag(name:"affected", value:"Microsoft Internet Explorer version
  9.x/10.x/11.x");

  script_tag(name:"solution", value:"The vendor has released updates. Please see the references for more information.");

  script_tag(name:"solution_type", value:"VendorFix");

  script_xref(name:"URL", value:"https://support.microsoft.com/en-us/kb/3134814");
  script_xref(name:"URL", value:"https://support.microsoft.com/en-us/kb/3134220");
  script_xref(name:"URL", value:"https://support.microsoft.com/en-us/kb/3134220");
  script_xref(name:"URL", value:"https://support.microsoft.com/en-us/kb/3141092");
  script_xref(name:"URL", value:"https://technet.microsoft.com/library/security/MS16-023");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("gb_ms_ie_detect.nasl");
  script_require_ports(139, 445);
  script_mandatory_keys("MS/IE/Version");
  exit(0);
}


include("smb_nt.inc");
include("secpod_reg.inc");
include("host_details.inc");
include("version_func.inc");
include("secpod_smb_func.inc");

if(hotfix_check_sp(winVista:3, win7:2, win7x64:2, win2008:3, win2008r2:2,
                   win2012:1,  win2012R2:1, win8_1:1, win8_1x64:1, win10:1, win10x64:1) <= 0){
  exit(0);
}

ieVer = get_app_version(cpe:CPE);
if(!ieVer || !(ieVer =~ "^(9|10|11)")){
  exit(0);
}

sysPath = smb_get_systemroot();
if(!sysPath ){
  exit(0);
}

dllVer = fetch_file_version(sysPath:sysPath, file_name:"system32\Mshtml.dll");
if(!dllVer){
  exit(0);
}

if(hotfix_check_sp(winVista:3, win2008:3) > 0)
{
  if(version_in_range(version:dllVer, test_version:"9.0.8112.16000", test_version2:"9.0.8112.16748")){
    Vulnerable_range = "9.0.8112.16000 - 9.0.8112.16748";
    VULN = TRUE ;
  }
  else if(version_in_range(version:dllVer, test_version:"9.0.8112.20000", test_version2:"9.0.8112.20863")){
    Vulnerable_range = "9.0.8112.20000 - 9.0.8112.20863";
    VULN = TRUE ;
  }
}

else if(hotfix_check_sp(win7:2, win7x64:2, win2008r2:2, win8_1:1, win8_1x64:1, win2012R2:1) > 0)
{
  if(version_in_range(version:dllVer, test_version:"11.0.9600.00000", test_version2:"11.0.9600.18230"))
  {
     Vulnerable_range = "11.0.9600.00000 - 11.0.9600.18230";
     VULN = TRUE ;
  }
}

else if(hotfix_check_sp(win2012:1) > 0)
{
  if(version_in_range(version:dllVer, test_version:"10.0.9200.16000", test_version2:"10.0.9200.17661"))
  {
    Vulnerable_range = "10.0.9200.16000 - 10.0.9200.17661";
    VULN = TRUE ;
  }
  else if(version_in_range(version:dllVer, test_version:"10.0.9200.20000", test_version2:"10.0.9200.21779"))
  {
    Vulnerable_range = "10.0.9200.20000 - 10.0.9200.21779";
    VULN = TRUE ;
  }
}

else if(hotfix_check_sp(win10:1, win10x64:1) > 0)
{
  if(version_is_less(version:dllVer, test_version:"11.0.10240.16724"))
  {
    Vulnerable_range = "Less than 11.0.10240.16724";
    VULN = TRUE ;
  }

  else if(version_in_range(version:dllVer, test_version:"11.0.10586.0", test_version2:"11.0.10586.161"))
  {
    Vulnerable_range = "11.0.10586.0 - 11.0.10586.161";
    VULN = TRUE ;
  }
}

if(VULN)
{
  report = 'File checked:     ' + sysPath + "\system32\Mshtml.dll" + '\n' +
           'File version:     ' + dllVer  + '\n' +
           'Vulnerable range: ' + Vulnerable_range + '\n' ;
  security_message(data:report);
  exit(0);
}
