###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_open_xchange_appsuite_58742.nasl 13381 2019-01-31 10:15:33Z ckuersteiner $
#
# Open-Xchange (OX) AppSuite Multiple Vulnerabilities (58742, 56457)
#
# Authors:
# Christian Kuersteiner <christian.kuersteiner@greenbone.net>
#
# Copyright:
# Copyright (c) 2019 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
###############################################################################

CPE = "cpe:/a:open-xchange:open-xchange_appsuite";

if (description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.141949");
  script_version("2019-04-01T07:47:16+0000");
  script_tag(name:"last_modification", value:"2019-04-01 07:47:16 +0000 (Mon, 01 Apr 2019)");
  script_tag(name:"creation_date", value:"2019-01-31 16:55:25 +0700 (Thu, 31 Jan 2019)");
  script_tag(name:"cvss_base", value:"5.5");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:S/C:P/I:P/A:N");

  script_cve_id("CVE-2018-13103", "CVE-2018-13104");

  script_tag(name:"qod_type", value:"remote_banner");

  script_tag(name:"solution_type", value:"VendorFix");

  script_name("Open-Xchange (OX) AppSuite Multiple Vulnerabilities (58742, 56457)");

  script_category(ACT_GATHER_INFO);

  script_copyright("This script is Copyright (C) 2019 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("gb_ox_app_suite_detect.nasl");
  script_mandatory_keys("open_xchange_appsuite/installed");

  script_tag(name:"summary", value:"Open-Xchange (OX AppSuite is prone to multiple vulnerabilities.");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is present on the target host.");

  script_tag(name:"insight", value:"Open-Xchange (OX AppSuite is prone to multiple vulnerabilities:

  - Cross-Site Scripting (BugID: 58742)

  - Server-Side Request Forgery (BugID: 56457)");

  script_tag(name:"affected", value:"OX AppSuite versions 7.8.4 and prior.");

  script_tag(name:"solution", value:"Update to version 7.6.3-rev41, 7.8.3-rev50, 7.8.4-rev39 or later.");

  script_xref(name:"URL", value:"https://seclists.org/fulldisclosure/2019/Jan/46");

  exit(0);
}

include("host_details.inc");
include("version_func.inc");

if (!port = get_app_port(cpe: CPE))
  exit(0);

if (!version = get_app_version(cpe: CPE, port: port))
  exit(0);

if (!revision = get_kb_item("open_xchange_appsuite/" + port + "/revision"))
  exit(0);

version += '.' + revision;

if (version_is_less(version: version, test_version: "7.6.3.41")) {
  report = report_fixed_ver(installed_version: version, fixed_version: "7.6.3.41");
  security_message(port: port, data: report);
  exit(0);
}

if (version_in_range(version: version, test_version: "7.8", test_version2: "7.8.3.49")) {
  report = report_fixed_ver(installed_version: version, fixed_version: "7.8.3.50");
  security_message(port: port, data: report);
  exit(0);
}

if (version_in_range(version: version, test_version: "7.8.4", test_version2: "7.8.4.38")) {
  report = report_fixed_ver(installed_version: version, fixed_version: "7.8.4.39");
  security_message(port: port, data: report);
  exit(0);
}

exit(99);
