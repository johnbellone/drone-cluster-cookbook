#
# Cookbook: drone-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
config = drone_config node['drone']['service_name'] do |r|
  node['drone']['config'].each_pair { |k,v| r.send(k, v) }
  notifies :restart, "docker_container[#{name}]", :delayed
end

docker_service 'default' do
  action [:create, :start]
end

docker_image node['drone']['service_name'] do
  repo node['drone']['image_repo']
  tag node['drone']['image_tag']
  notifies :restart, "docker_container[#{name}]", :delayed
end

docker_container node['drone']['service_name'] do
  repo node['drone']['image_repo']
  tag node['drone']['image_tag']
  command 'drone'
  volumes ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']
  restart_policy 'always'
  detach true
  port "80:#{config.server_port}"
end
