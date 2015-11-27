#
# Cookbook: drone-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
default['drone']['service_name'] = 'drone'
default['drone']['service_user'] = 'drone'
default['drone']['service_group'] = 'drone'

default['drone']['config']['path'] = '/etc/default/drone'
