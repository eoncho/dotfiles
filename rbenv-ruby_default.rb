#
# Cookbook Name:: rbenv-ruby
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
install_ruby_version="2.1.0"
home_dir="/home/vagrant"
make_usr="vagrant"
make_grp="vagrant"

%W[ #{home_dir}/.rbenv #{home_dir}/tmp ].each do |path|
  directory path do
    mode "00755"
    action :create
    user "#{make_usr}"
    group "#{make_grp}"
    not_if "ls #{path}"
  end
end

git "#{home_dir}/tmp/rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :sync
  user "#{make_usr}"
  group "#{make_grp}"
  not_if "ls #{home_dir}/tmp/rbenv"
end

# copy
execute "copy_rbenv" do
  command <<-EOF
          cp -r #{home_dir}/tmp/rbenv/* #{home_dir}/.rbenv
  EOF
  not_if "ls #{home_dir}/.rbenv/bin"
end


execute "source_profile" do
  command <<-EOF
          echo 'export RBENV_ROOT=#{home_dir}/.rbenv' >> #{home_dir}/.bash_profile
          echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> #{home_dir}/.bash_profile
          echo 'eval "$(rbenv init -)"' >> #{home_dir}/.bash_profile
          source #{home_dir}/.bash_profile
  EOF
  not_if "grep rbenv #{home_dir}/.bash_profile"
end

directory "#{home_dir}/.rbenv/plugins" do
  mode "00755"
  action :create
  user "#{make_usr}"
  group "#{make_grp}"
  not_if "ls #{home_dir}/.rbenv/plugins"
end

git "#{home_dir}/.rbenv/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :sync
  user "#{make_usr}"
  group "#{make_grp}"
end

bash "install_ruby_build" do
  cwd "#{home_dir}/.rbenv/plugins/ruby-build"
  code <<-EOF
       ./install.sh
  EOF
  environment 'PREFIX' => "#{home_dir}"
end

bash "install_ruby" do
  cwd "#{home_dir}/.rbenv/bin"
  code <<-EOF
       source #{home_dir}/.bash_profile
       ./rbenv install #{install_ruby_version}
       ./rbenv rehash
       ./rbenv global #{install_ruby_version}
  EOF
  not_if "ls #{home_dir}/.rbenv/shims/ruby"
end

directory "#{home_dir}/tmp" do
  recursive true
  action :delete
end
