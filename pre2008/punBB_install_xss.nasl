# OpenVAS Vulnerability Test
# Description: PunBB install.php XSS
#
# Authors:
# David Maciejak <david dot maciejak at kyxar dot fr>
#
# Copyright:
# Copyright (C) 2004 David Maciejak
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2,
# as published by the Free Software Foundation
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
#

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.15939");
  script_version("2019-04-24T07:26:10+0000");
  script_tag(name:"last_modification", value:"2019-04-24 07:26:10 +0000 (Wed, 24 Apr 2019)");
  script_tag(name:"creation_date", value:"2005-11-03 14:08:04 +0100 (Thu, 03 Nov 2005)");
  script_bugtraq_id(11845);
  script_xref(name:"OSVDB", value:"7976");
  script_name("PunBB install.php XSS");
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");
  script_category(ACT_GATHER_INFO);
  script_copyright("This script is Copyright (C) 2004 David Maciejak");
  script_family("Web application abuses");
  script_dependencies("punBB_detect.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  script_xref(name:"URL", value:"http://www.punbb.org/changelogs/1.1.1_to_1.1.2.txt");

  script_tag(name:"solution", value:"Update to PunBB version 1.1.2 or later.");

  script_tag(name:"summary", value:"The remote version of PunBB is vulnerable to cross-site scripting
  flaws through 'install.php' script.");

  script_tag(name:"impact", value:"With a specially-crafted URL, an attacker can inject arbitrary HTML
  and script code into a user's browser resulting in the possible theft of authentication cookies,
  mis-representation of site contents, and the like.");

  script_tag(name:"qod_type", value:"remote_banner");
  script_tag(name:"solution_type", value:"VendorFix");

  exit(0);
}

include("http_func.inc");

port = get_http_port(default:80);

install = get_kb_item(string("www/", port, "/punBB"));
if(isnull(install))
  exit(0);

matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches)) {
  ver = matches[1];

  if (egrep(pattern: "^(0\.|1\.0|1\.1[^.]|1\.1\.1)",string:ver)) {
    security_message(port:port);
    exit(0);
  }
}

exit(99);