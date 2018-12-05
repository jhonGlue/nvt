##############################################################################
# OpenVAS Vulnerability Test
# $Id: secpod_adobe_prdts_mult_vuln_jun10_lin.nasl 12653 2018-12-04 15:31:25Z cfischer $
#
# Adobe Flash Player/Air Multiple Vulnerabilities - June10 (Linux)
#
# Authors:
# Antu Sanadi <santu@secpod.com>
#
# Copyright:
# Copyright (c) 2010 SecPod, http://www.secpod.com
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
  script_oid("1.3.6.1.4.1.25623.1.0.902194");
  script_version("$Revision: 12653 $");
  script_tag(name:"last_modification", value:"$Date: 2018-12-04 16:31:25 +0100 (Tue, 04 Dec 2018) $");
  script_tag(name:"creation_date", value:"2010-06-22 13:34:32 +0200 (Tue, 22 Jun 2010)");
  script_cve_id("CVE-2008-4546", "CVE-2009-3793", "CVE-2010-1297", "CVE-2010-2160",
                "CVE-2010-2161", "CVE-2010-2162", "CVE-2010-2163", "CVE-2010-2164",
                "CVE-2010-2165", "CVE-2010-2166", "CVE-2010-2167", "CVE-2010-2169",
                "CVE-2010-2170", "CVE-2010-2171", "CVE-2010-2172", "CVE-2010-2173",
                "CVE-2010-2174", "CVE-2010-2175", "CVE-2010-2176", "CVE-2010-2177",
                "CVE-2010-2178", "CVE-2010-2179", "CVE-2010-2180", "CVE-2010-2181",
                "CVE-2010-2182", "CVE-2010-2183", "CVE-2010-2184", "CVE-2010-2185",
                "CVE-2010-2186", "CVE-2010-2187", "CVE-2010-2188", "CVE-2010-2189");
  script_bugtraq_id(40759);
  script_tag(name:"cvss_base", value:"9.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:C/I:C/A:C");
  script_name("Adobe Flash Player/Air Multiple Vulnerabilities - June10 (Linux)");
  script_xref(name:"URL", value:"http://www.vupen.com/english/advisories/2010/1421");
  script_xref(name:"URL", value:"http://securitytracker.com/alerts/2010/Jun/1024086.html");
  script_xref(name:"URL", value:"http://www.adobe.com/support/security/bulletins/apsb10-14.html");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2010 SecPOd");
  script_family("General");
  script_dependencies("gb_adobe_flash_player_detect_lin.nasl");
  script_mandatory_keys("Adobe/Air_or_Flash_or_Reader/Linux/Installed");

  script_tag(name:"impact", value:"Successful exploitation will allow remote attackers to obtain sensitive
  information or cause a denial of service.");

  script_tag(name:"affected", value:"Adobe AIR version prior to 2.0.2.12610,
  Adobe Flash Player before 9.0.277.0 and 10.x before 10.1.53.64 on Linux.");

  script_tag(name:"insight", value:"The flaws are due to input validation errors, memory corruptions,
  array indexing, use-after-free, integer and buffer overflows, and
  invalid pointers when processing malformed Flash content.");

  script_tag(name:"solution", value:"Update to Adobe  Air2.0.2.12610 or Adobe Flash Player 9.0.277.0 or 10.0.45.2.");

  script_tag(name:"summary", value:"This host is installed with Adobe Flash Player/Air and is prone to
  multiple vulnerabilities.");

  script_tag(name:"qod_type", value:"executable_version");
  script_tag(name:"solution_type", value:"VendorFix");

  exit(0);
}

include("version_func.inc");

playerVer = get_kb_item("AdobeFlashPlayer/Linux/Ver");
if(playerVer != NULL)
{
  if(version_is_less(version:playerVer, test_version:"9.0.277.0") ||
     version_in_range(version:playerVer, test_version:"10.0", test_version2:"10.0.45.1"))
  {
    security_message( port: 0, data: "The target host was found to be vulnerable" );
    exit(0);
  }
}

airVer = get_kb_item("Adobe/Air/Linux/Ver");
if(airVer != NULL)
{
  if(version_is_less(version:airVer, test_version:"2.0.2.12610")){
    security_message( port: 0, data: "The target host was found to be vulnerable" );
  }
}
