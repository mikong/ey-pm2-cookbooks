execute "install pm2" do
  command "npm install -g pm2"
  notifies :create, "link[/usr/bin/pm2]"
end

link "/usr/bin/pm2" do
  to "/opt/nodejs/current/bin/pm2"
  # only_if { File.exist?("/opt/nodejs/current/bin/pm2") }
  # not_if { File.exists?("/usr/bin/pm2") }
  notifies :run, "execute[start pm2 at boot]"
  action :nothing
end

execute "start pm2 at boot" do
  command "pm2 startup openrc"
  # only_if { ::File.exists?("/usr/bin/pm2") }
  action :nothing
end
