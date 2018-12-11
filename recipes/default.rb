#
# Cookbook:: lc4_splunk
# Recipe:: default
#
# Copyright:: 2018,  Larry Charbonneau
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

package 'wget'

execute 'download splunk rpm' do
  command "wget -O splunk-7.2.1-be11b2c46e23-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.2.1&product=splunk&filename=splunk-7.2.1-be11b2c46e23-linux-2.6-x86_64.rpm&wget=true'"
  not_if { ::File.exist?('/splunk-7.2.1-be11b2c46e23-linux-2.6-x86_64.rpm') }
end

user 'splunk' do
  comment 'splunk service acct'
  manage_home true
  home '/home/splunk'
  shell '/bin/bash'
  password '$1$5KNIo.OG$wAMZjyK5DhjeJp6f0PSIE1'
  action :create
end

directory '/opt/splunk' do
  owner 'splunk'
  group 'splunk'
  action :create
end

rpm_package './splunk-7.2.1-be11b2c46e23-linux-2.6-x86_64.rpm' do
  action :install
  notifies :run, 'execute[start splunk]'
end

firewalld_manager '8000/tcp' do
  action :create
  notifies :reload, 'firewalld_manager[reload]'
end

firewalld_manager 'reload' do
  action :nothing
end

execute 'start splunk' do
  command '/opt/splunk/bin/splunk start --accept-license'
  user 'splunk'
  action :nothing
  notifies :run, 'execute[enable splunk]'
end

execute 'enable splunk' do
  command '/opt/splunk/bin/splunk enable boot-start'
  user 'splunk'
  action :nothing
end
