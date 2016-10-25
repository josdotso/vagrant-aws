require "vagrant"

module VagrantPlugins
  module Fusion
    module Errors
      class VagrantFusionError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_fusion.errors")
      end

      class FogError < VagrantFusionError
        error_key(:fog_error)
      end

      class InternalFogError < VagrantFusionError
        error_key(:internal_fog_error)
      end

      class InstanceReadyTimeout < VagrantFusionError
        error_key(:instance_ready_timeout)
      end

      class InstancePackageError < VagrantFusionError
        error_key(:instance_package_error)
      end

      class InstancePackageTimeout < VagrantFusionError
        error_key(:instance_package_timeout)
      end

      class RsyncError < VagrantFusionError
        error_key(:rsync_error)
      end

      class MkdirError < VagrantFusionError
        error_key(:mkdir_error)
      end

      class ElbDoesNotExistError < VagrantFusionError
        error_key("elb_does_not_exist")
      end
    end
  end
end
