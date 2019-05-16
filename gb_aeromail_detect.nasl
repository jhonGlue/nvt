###############################################################################
# OpenVAS Vulnerability Test
#
# AeroMail Detection
#
# Authors:
# Michael Meyer <michael.meyer@greenbone.net>
#
# Copyright:
# Copyright (c) 2011 Greenbone Networks GmbH
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

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.103204");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_version("2019-05-13T14:05:09+0000");
  script_tag(name:"last_modification", value:"2019-05-13 14:05:09 +0000 (Mon, 13 May 2019)");
  script_tag(name:"creation_date", value:"2011-08-17 15:40:19 +0200 (Wed, 17 Aug 2011)");
  script_tag(name:"cvss_base", value:"0.0");
  script_name("AeroMail Detection");
  script_category(ACT_GATHER_INFO);
  script_tag(name:"qod_type", value:"remote_banner");
  script_family("Product detection");
  script_copyright("This script is Copyright (C) 2011 Greenbone Networks GmbH");
  script_dependencies("find_service.nasl", "http_version.nasl");
  script_require_ports("Services/www", 80);
  script_exclude_keys("Settings/disable_cgi_scanning");

  script_tag(name:"summary", value:"This host is running AeroMail, a web-based e-mail client written in
  PHP.");

  script_xref(name:"URL", value:"http://www.nicolaas.net/aeromail/");

  exit(0);
}

include("http_func.inc");
include("http_keepalive.inc");
include("host_details.inc");

SCRIPT_DESC = "AeroMail Detection";

port = get_http_port(default:80);
if(!can_host_php(port:port))exit(0);

foreach dir( make_list_unique( "/aeromail", "/mail", cgi_dirs( port:port ) ) ) {

 install = dir;
 if( dir == "/" ) dir = "";
 url = dir + "/index.php";
 buf = http_get_cache( item:url, port:port );
 if( buf == NULL ) continue;

 if(egrep(pattern: 'realm="AeroMail"', string: buf, icase: FALSE))
 {

    vers = string("unknown");
    version = eregmatch(string: buf, pattern: "AeroMail ([0-9.]+)<",icase:TRUE);

    if ( !isnull(version[1]) ) {
       vers=chomp(version[1]);
    }

    set_kb_item(name: string("www/", port, "/AeroMail"), value: string(vers," under ",install));
    set_kb_item(name: "aeromail/detected", value: TRUE);

    if(vers == "unknown") {
      register_host_detail(name:"App", value:string("cpe:/a:aeromail:aeromail"), desc:SCRIPT_DESC);
    } else {
      register_host_detail(name:"App", value:string("cpe:/a:aeromail:aeromail:",vers), desc:SCRIPT_DESC);
    }

    info = string("AeroMail Version '");
    info += string(vers);
    info += string("' was detected on the remote host in the following directory(s):\n\n");
    info += string(install, "\n");

    log_message(port:port,data:info);
    exit(0);
  }
}

exit(0);
