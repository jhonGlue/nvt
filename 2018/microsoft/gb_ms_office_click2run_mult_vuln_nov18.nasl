###############################################################################
# OpenVAS Vulnerability Test
#
# Microsoft Office 365 (2016 Click-to-Run) Multiple Vulnerabilities-November18
#
# Authors:
# Shakeel <bshakeel@secpod.com>
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.814283");
  script_version("2019-05-03T08:55:39+0000");
  script_cve_id("CVE-2018-8574", "CVE-2018-8577", "CVE-2018-8522", "CVE-2018-8524",
                "CVE-2018-8558", "CVE-2018-8576", "CVE-2018-8579", "CVE-2018-8582",
                "CVE-2018-8575", "CVE-2018-8539", "CVE-2018-8573", "CVE-2018-8546");
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_tag(name:"last_modification", value:"2019-05-03 08:55:39 +0000 (Fri, 03 May 2019)");
  script_tag(name:"creation_date", value:"2018-11-14 14:56:39 +0530 (Wed, 14 Nov 2018)");
  script_name("Microsoft Office 365 (2016 Click-to-Run) Multiple Vulnerabilities-November18");

  script_tag(name:"summary", value:"This host is missing an important security
  update according to Microsoft Office Click-to-Run updates.");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is present
  on the target host.");

  script_tag(name:"insight", value:"Multiple flaws exists due to,

  - Multiple errors in Microsoft Excel software when the software fails to properly
    handle objects in memory.

  - Multiple errors in Microsoft Outlook software when it fails to properly handle
    objects in memory.

  - An error in Microsoft Outlook which fails to respect 'Default link type'
    settings configured via the SharePoint Online Admin Center.

  - An error in Microsoft Outlook when attaching files to Outlook messages.

  - An error in the way that Microsoft Outlook parses specially modified rule
    export files.

  - An error in Microsoft Project software when it fails to properly handle objects
    in memory.

  - An error in Microsoft Word software when it fails to properly handle objects
    in memory.

  - An error in Skype for Business in handling emojis.");

  script_tag(name:"impact", value:"Successful exploitation will allow an attacker
  to run arbitrary code in the context of the current user, conduct a denial-of-service
  attack and gain access to sensitive information.");

  script_tag(name:"affected", value:"Microsoft Office 365 (2016 Click-to-Run)");

  script_tag(name:"solution", value:"Upgrade to latest version of Microsoft Office
  365 (2016 Click-to-Run) with respect to update channel used. Please see the references for more information.");

  script_tag(name:"solution_type", value:"VendorFix");
  script_tag(name:"qod_type", value:"registry");
  script_xref(name:"URL", value:"https://docs.microsoft.com/en-us/officeupdates/monthly-channel-2018");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2018 Greenbone Networks GmbH");
  script_family("Windows : Microsoft Bulletins");
  script_dependencies("gb_ms_office_click2run_detect_win.nasl");
  script_mandatory_keys("MS/Off/C2R/Ver", "MS/Office/C2R/UpdateChannel");

  exit(0);
}


include("host_details.inc");
include("version_func.inc");

officeVer = get_kb_item("MS/Off/C2R/Ver");
UpdateChannel = get_kb_item("MS/Office/C2R/UpdateChannel");
officePath = get_kb_item("MS/Off/C2R/InstallPath");

if(!(officeVer =~ "^(16\.)")){
  exit(0);
}

## 1810 (Build 11001.20108)
if(UpdateChannel == "Monthly Channel")
{
  if(version_is_less(version:officeVer, test_version:"16.0.11001.20108")){
    fix = "1810 (Build 11001.20108)";
  }
}

##1808 (Build 10730.20205)
else if(UpdateChannel == "Semi-Annual Channel (Targeted)")
{
  if(version_is_less(version:officeVer, test_version:"16.0.10730.20205")){
    fix = "1808 (Build 10730.20205)";
  }
}

## 1803 (Build 9126-2315)
## 1708 (Build 8431.2329)
else if(UpdateChannel == "Semi-Annual Channel")
{
  if(version_is_less(version:officeVer, test_version:"16.0.8431.2329")){
    fix = "1708 (Build 8431.2329)";
  }
  else if(version_in_range(version:officeVer, test_version:"16.0.9000", test_version2:"16.0.9126.2315")){
    fix = "1803 (Build 9126.2315)";
  }
}

if(fix)
{
  report = report_fixed_ver(installed_version:officeVer, fixed_version:fix, install_path:officePath);
  security_message(data:report);
  exit(0);
}
exit(99);
