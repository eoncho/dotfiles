#
# Cookbook Name:: rbenv-ruby
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
install_ruby_version="2.1.0p0"

directory "/home/vagrant/.rbenv" do
  mode "00755"
  action :create
  not_if "ls /home/vagrant/.rbenv"
end

git "/home/vagrant/.rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :sync
  not_if "ls /home/vagrant/.rbenv"
end

execute "source_profile" do
  command <<-EOF
          echo 'export RBENV_ROOT=/home/vagrant/.rbenv' >> /home/vagrant/.bashrc
          echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/vagrant/.bashrc
          echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bashrc
          source /home/vagrant/.bashrc
  EOF
  not_if "grep rbenv /home/vagrant/.bashrc"
end

directory "/home/vagrant/.rbenv/plugins" do
  mode "00755"
  action :create
  not_if "ls /home/vagrant/.rbenv/plugins"
end

git "/home/vagrant/.rbenv/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :sync
end

bash "install_ruby_build" do
  cwd "/home/vagrant/.rbenv/plugins/ruby-build"
  code <<-EOF
       ./install.sh
  EOF
  environment 'PREFIX' => "/home/vagrant"
end

bash "install_ruby" do
  cwd "/home/vagrant/.rbenv/bin"
  code <<-EOF
       ./rbenv install #install_ruby_version
       ./rbenv rehash
       ./rbenv global #install_ruby_version
  EOF
  not_if "ls /home/vagrant/.rbenv/shims/ruby"
end
