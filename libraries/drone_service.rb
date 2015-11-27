#
# Cookbook: drone-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

module DroneClusterCookbook
  module Resource
    # @since 1.0.0
    class DroneService < Chef::Resource
      include Poise
      provides(:drone_service)
      include PoiseService::ServiceMixin

      attribute(:version, kind_of: String, default: 'latest')
      attribute(:config_file, kind_of: String, default: '/etc/default/drone')
    end
  end

  module Provider
    # @since 1.0.0
    class DroneService < Chef::Provider
      include Poise
      provides(:drone_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do
          docker_service 'default' do
            action [:create, :start]
          end

          docker_image 'drone/drone' do
            tag new_resource.version
          end
        end
        super
      end

      private

      def service_options(resource)
        resource.command('docker start drone')
      end
    end
  end
end
