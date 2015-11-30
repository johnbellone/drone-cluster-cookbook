#
# Cookbook: drone-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
default['drone']['config']['path'] = '/etc/default/drone'

default['drone']['service_name'] = 'drone'
default['drone']['image_repo'] = 'drone/drone'
default['drone']['image_tag'] = 'latest'
