#
# Cookbook: drone-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise'

module DroneClusterCookbook
  module Resource
    class DroneConfig < Chef::Resource
      include Poise(fused: true)
      provides(:drone_config)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:owner, kind_of: String)
      attribute(:group, kind_of: String)
      attribute(:mode, kind_of: String, default: '0640')

      attribute(:database_driver, equal_to: %w{mysql postgres sqlite})
      attribute(:database_config, kind_of: String)
      attribute(:http_proxy, kind_of: String)
      attribute(:https_proxy, kind_of: String)
      attribute(:no_proxy, kind_of: String)
      attribute(:plugin_filter, kind_of: [Array, String])
      attribute(:remote_driver, equal_to: %w{github github_enterprise bitbucket gitlab})
      attribute(:remote_config, kind_of: String)
      attribute(:server_address, kind_of: String, default: ':8080')
      attribute(:server_ssl_key, kind_of: String)
      attribute(:server_ssl_certificate, kind_of: String)

      def to_hash
        {}.tap do |h|
          h.merge('DATABASE_DRIVER' => database_driver) if database_driver
          h.merge('DATABASE_CONFIG' => database_config) if database_config
          h.merge('REMOTE_DRIVER' => remote_driver) if remote_driver
          h.merge('REMOTE_CONFIG' => remote_config) if remote_config
          h.merge('SERVER_ADDR' => server_address) if server_address
          h.merge('SERVER_KEY' => server_ssl_key) if server_ssl_key
          h.merge('SERVER_CERT' => server_ssl_certificate) if server_ssl_certificate
          h.merge('HTTP_PROXY' => http_proxy) if http_proxy
          h.merge('HTTPS_PROXY' => https_proxy) if https_proxy
          h.merge('NO_PROXY' => no_proxy) if no_proxy
          h.merge('PLUGIN_FILTER' => plugin_filter.flatten.join(' ')) if plugin_filter
        end
      end

      action(:create) do
        notifying_block do
          rc_file new_resource.path do
            type 'bash'
            mode new_resource.mode
            owner new_resource.owner
            group new_resource.group
            options new_resource.to_hash
          end
        end
      end
    end
  end
end
