#
# Cookbook: drone-cluster
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
require 'poise'

module DroneClusterCookbook
  module Resource
    # A custom resource for executing Drone CLI commands.
    # @since 1.0.0
    class DroneCommand < Chef::Resource
      include Poise(fused: true)
      provides(:drone_command)

      attribute(:command, kind_of: String, name_attribute: true)
      attribute(:token, kind_of: String, required: true)
      attribute(:server, kind_of: String, required: true)

      action(:run) do
        notifying block do
          archive = remote_file ::File.join(Chef::Config[:file_cache_path], 'drone-cli.tar.gz') do
            source 'http://downloads.drone.io/drone-cli/drone_linux_amd64.tar.gz'
            action :create_if_missing
          end

          bash ['tar xz', archive.path, '-C /usr/local/bin/'].join(' ') do
            subscribes :run, "remote_file[#{archive.path}]", :immediately
            action :nothing
          end

          bash ['drone', new_resource.command].join(' ') do
            sensitive true
            environment(
              'PATH' => '/usr/local/bin',
              'DRONE_TOKEN' => new_resource.token,
              'DRONE_SERVER' => new_resource.server)
          end
        end
      end
    end
  end
end
