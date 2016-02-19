#
# Cookbook: drone-cluster
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
default['drone']['config']['path'] = '/etc/drone/dronerc'

default['drone']['container']['name'] = 'drone'
default['drone']['container']['image_repo'] = 'drone/drone'
default['drone']['container']['image_tag'] = 'latest'
