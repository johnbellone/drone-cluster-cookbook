#
# Cookbook: drone-cluster
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
directory '/var/lib/drone'

docker_installation 'default'

docker_service 'default' do
  action [:create, :start]
end

docker_image node['drone']['container']['name'] do
  repo node['drone']['container']['image_repo']
  tag node['drone']['container']['image_tag']
  notifies :restart, "docker_container[#{name}]", :delayed
end

config = drone_config node['drone']['container']['name'] do |r|
  node['drone']['config'].each_pair { |k,v| r.send(k, v) }
  notifies :restart, "docker_container[#{name}]", :delayed
end

docker_container node['drone']['container']['name'] do |r|
  repo node['drone']['container']['image_repo']
  tag node['drone']['container']['image_tag']
  command 'drone'
  volumes ['/var/lib/drone:/var/lib/drone', '/var/run/docker.sock:/var/run/docker.sock']
  restart_policy 'always'
  port "80:#{config.server_port}"
end
