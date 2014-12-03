#
# Cookbook Name:: site_httpd
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# yum repo add

bash "yum_repo_add" do
  cwd "/etc/yum.repos.d/"
  code <<-EOF
         sudo wget http://wing-repo.net/wing/6/EL6.wing.repo
         sudo wget http://wing-repo.net/wing/extras/6/EL6.wing-extras.repo
         sudo yum clean all
         sudo yum -y install yum-priorities
  EOF
end

%w[ httpd mod_ssl ].each do |mods|
  package mods do
    action :install
    options '--enablerepo=wing'
  end
end

%w[ /var/www/ei-front /var/www/ei-front/current/ /var/www/ei-front/current/public ].each do |path|
  directory path do
    owner "vagrant"
    group "vagrant"
    mode "0755"
    action :create
  end
end

service "httpd" do
  action [:start, :enable]
end

template "httpd.conf" do
  path "/etc/httpd/conf/httpd.conf"
  source "httpd.conf.erb"
  mode 0644
end

template "ei-front.conf" do
  path "/etc/httpd/conf.d/ei-front.conf"
  source "ei-front.conf.erb"
  mode 0644
  notifies :restart, 'service[httpd]'
end
