###############################################################################
# OpenVAS Vulnerability Test
#
# Jenkins Multiple Cross Site Scripting Vulnerabilities August16 (Windows)
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

CPE = "cpe:/a:jenkins:jenkins";

if(description)
{
  script_oid("1.3.6.1.4.1.25623.1.0.808275");
  script_version("2019-07-30T03:00:13+0000");
  script_cve_id("CVE-2012-0324", "CVE-2012-0325");
  script_bugtraq_id(52384);
  script_tag(name:"cvss_base", value:"4.3");
  script_tag(name:"cvss_base_vector", value:"AV:N/AC:M/Au:N/C:N/I:P/A:N");
  script_tag(name:"last_modification", value:"2019-07-30 03:00:13 +0000 (Tue, 30 Jul 2019)");
  script_tag(name:"creation_date", value:"2016-08-04 13:00:05 +0530 (Thu, 04 Aug 2016)");

  script_name("Jenkins Multiple Cross Site Scripting Vulnerabilities August16 (Windows)");

  script_tag(name:"summary", value:"This host is installed with CloudBees
  Jenkins and is prone to multiple cross-site scripting vulnerabilities.");

  script_tag(name:"vuldetect", value:"Checks if a vulnerable version is present on the target host.");

  script_tag(name:"insight", value:"The multiple flaws are due to multiple input validation errors.");

  script_tag(name:"impact", value:"Successful exploitation will allow remote
  attackers to inject malicious HTMLs to pages served by Jenkins. This allows
  an attacker to escalate his privileges by hijacking sessions of other users.");

  script_tag(name:"affected", value:"CloudBees Jenkins LTS before 1.424.5 on Windows.");

  script_tag(name:"solution", value:"Upgrade to CloudBees Jenkins LTS 1.424.5 or later.");

  script_tag(name:"solution_type", value:"VendorFix");

  script_tag(name:"qod_type", value:"remote_banner");

  script_xref(name:"URL", value:"https://www.cloudbees.com/jenkins-security-advisory-2012-03-05");

  script_category(ACT_GATHER_INFO);
  script_copyright("Copyright (C) 2016 Greenbone Networks GmbH");
  script_family("Web application abuses");
  script_dependencies("gb_jenkins_consolidation.nasl", "os_detection.nasl");
  script_mandatory_keys("jenkins/detected", "Host/runs_windows");

  exit(0);
}

include("host_details.inc");
include("version_func.inc");

if(!port = get_app_port(cpe:CPE))
  exit(0);

if(!infos = get_app_full(cpe:CPE, port:port))
  exit(0);

if (!version = infos["version"])
  exit(0);

location = infos["location"];
proto = infos["proto"];

if(version_is_less_equal(version:version, test_version:"1.424.3")) {
  report = report_fixed_ver(installed_version:version, fixed_version:"1.424.5", install_path: location);
  security_message(data:report, port:port, proto:proto);
  exit(0);
}

exit(99);
