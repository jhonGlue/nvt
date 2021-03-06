###############################################################################
# OpenVAS Vulnerability Test
# $Id: gb_vlc_media_player_remote_detect.nasl 10915 2018-08-10 15:50:57Z cfischer $
#
# VLC Media Player Remote Version Detection
#
# Authors:
# Rinu Kuriakose <krinu@secpod.com>
#
# Copyright:
# Copyright (C) 2015 Greenbone Networks GmbH, http://www.greenbone.net
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
  script_oid("1.3.6.1.4.1.25623.1.0.806038");
  script_version("$Revision: 10915 $");
  script_tag(name:"cvss_base", value:"0.0");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:L/Au:N/C:N/I:N/A:N");
  script_tag(name:"last_modification", value:"$Date: 2018-08-10 17:50:57 +0200 (Fri, 10 Aug 2018) $");
  script_tag(name:"creation_date", value:"2015-09-07 14:21:40 +0530 (Mon, 07 Sep 2015)");
  script_name("VLC Media Player Remote Version Detection");
  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2015 Greenbone Networks GmbH");
  script_family("Product detection");
  script_dependencies("gb_get_http_banner.nasl");
  script_require_ports("Services/www", 8080);
  script_mandatory_keys("VLC_stream/banner");

  script_tag(name:"summary", value:"Detects the installed version of
  VLC Media Player.

  This script sends HTTP GET request and try to get the version from the
  response, and sets the result in KB.");

  script_tag(name:"qod_type", value:"remote_banner");

  exit(0);
}

include("http_func.inc");
include("cpe.inc");
include("host_details.inc");

port = get_http_port(default:8080);

## GET banner
if( ! banner = get_http_banner( port:port ) ) exit( 0 );

if( 'WWW-Authenticate: Basic realm="VLC stream"' >< banner ) {

  install = "/";
  version = "unknown";

  set_kb_item( name:"www/" + port + "/VLC Media Player", value:version );
  set_kb_item( name:"VLC Media Player/Installed", value:TRUE );

  cpe = build_cpe( value:version, exp:"^([0-9.]+)", base:"cpe:/a:videolan:vlc_media_player:" );
  if( ! cpe )
    cpe = "cpe:/a:videolan:vlc_media_player";

  register_product( cpe:cpe, location:install, port:port );

  log_message( data:build_detection_report( app:"VLC Media Player",
                                            version:version,
                                            install:install,
                                            cpe:cpe ),
                                            port:port );
}

exit( 0 );
