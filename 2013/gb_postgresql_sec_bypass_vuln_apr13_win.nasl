###############################################################################
# OpenVAS Vulnerability Test
#
# PostgreSQL Security Bypass Vulnerability - Apr13 (Windows)
#
# Authors:
# Thanga Prakash S <tprakash@secpod.com>
#
# Copyright:
# Copyright (c) 2013 Greenbone Networks GmbH, http://www.greenbone.net
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

CPE = "cpe:/a:postgresql:postgresql";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.803475");
  script_version("2019-05-20T11:12:48+0000");
  script_cve_id("CVE-2013-1901");
  script_bugtraq_id(58878);
  script_tag(name:"cvss_base", value:"4.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:S/C:N/I:P/A:N");
  script_tag(name:"last_modification", value:"2019-05-20 11:12:48 +0000 (Mon, 20 May 2019)");
  script_tag(name:"creation_date", value:"2013-04-09 17:48:56 +0530 (Tue, 09 Apr 2013)");
  script_name("PostgreSQL Security Bypass Vulnerability - Apr13 (Windows)");
  script_xref(name:"URL", value:"http://secunia.com/advisories/52837");
  script_xref(name:"URL", value:"http://securitytracker.com/id?1028387");
  script_xref(name:"URL", value:"http://www.postgresql.org/about/news/1456");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (c) 2013 Greenbone Networks GmbH");
  script_family("Databases");
  script_dependencies("postgresql_detect.nasl", "os_detection.nasl");
  script_require_ports("Services/postgresql", 5432);
  script_mandatory_keys("PostgreSQL/installed", "Host/runs_windows");

  script_tag(name:"impact", value:"Successful exploitation will allow remote attackers to bypass security
  access to restricted backup files.");

  script_tag(name:"affected", value:"PostgreSQL version 9.2.x before 9.2.4 and 9.1.x before 9.1.9");

  script_tag(name:"insight", value:"Improper handling of a call for the pg_start_backup() or pg_stop_backup()
  functions.");

  script_tag(name:"solution", value:"Upgrade to PostgreSQL 9.1.8 or 9.2.3 or later.");

  script_tag(name:"summary", value:"This host is installed with PostgreSQL and is prone to security
  bypass vulnerability.");

  script_tag(name:"qod_type", value:"remote_banner");
  script_tag(name:"solution_type", value:"VendorFix");

  exit(0);
}

include("misc_func.inc");
include("version_func.inc");
include("host_details.inc");

if(!pgsqlPort = get_app_port(cpe:CPE)) exit(0);

pgsqlVer = get_app_version(cpe:CPE, port:pgsqlPort);
if(!pgsqlVer || pgsqlVer !~ "^9\.[12]\."){
  exit(0);
}

if(version_in_range(version:pgsqlVer, test_version:"9.1", test_version2:"9.1.8") ||
   version_in_range(version:pgsqlVer, test_version:"9.2", test_version2:"9.2.3"))
{
  security_message(port:pgsqlPort);
  exit(0);
}
