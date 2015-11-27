#
# Cookbook: drone-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
include_recipe 'build-essential::default'

node.default['go']['version'] = '1.5'
node.default['go']['from_source'] = true
include_recipe 'golang::default'

poise_service_user node['drone']['service_user'] do
  group node['drone']['service_group']
end

drone_config node['drone']['service_name'] do |r|
  node['drone']['config'].each_pair { |k,v| r.send(k, v) }
  notifies :restart, "drone_service[#{name}]", :delayed
end

drone_service node['drone']['service_name'] do |r|
  config_file node['drone']['config']['path']
  node['drone']['service'].each_pair { |k,v| r.send(k, v) }
end
