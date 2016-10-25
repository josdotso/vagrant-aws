require "fog"
require "log4r"

module VagrantPlugins
  module Fusion
    module Action
      # This action connects to Fusion, verifies credentials work, and
      # puts the Fusion connection object into the `:fusion_compute` key
      # in the environment.
      class ConnectFusion
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_fusion::action::connect_fusion")
        end

        def call(env)
          # Get the region we're going to booting up in
          region = env[:machine].provider_config.region

          # Get the configs
          region_config = env[:machine].provider_config.get_region_config(region)

          # Build the fog config
          fog_config = {
            :provider => :fusion,
            :region   => region
          }
          if region_config.use_iam_profile
            fog_config[:use_iam_profile] = true
          else
            fog_config[:fusion_access_key_id] = region_config.access_key_id
            fog_config[:fusion_secret_access_key] = region_config.secret_access_key
            fog_config[:fusion_session_token] = region_config.session_token
          end

          fog_config[:endpoint] = region_config.endpoint if region_config.endpoint
          fog_config[:version]  = region_config.version if region_config.version

          @logger.info("Connecting to Fusion...")
          env[:fusion_compute] = Fog::Compute.new(fog_config)
          env[:fusion_elb]     = Fog::Fusion::ELB.new(fog_config.except(:provider, :endpoint))

          @app.call(env)
        end
      end
    end
  end
end
