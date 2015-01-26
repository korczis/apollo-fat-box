# encoding: utf-8

require 'pmap'

require_relative 'provider_base'

module Apollon
  module Provider
    class Aws < ProviderBase
      class Machine < ProviderBase::Machine
        def initialize(provider, compute, machine = nil)
          super(provider, machine)
          @compute = compute
        end
      end

      REGIONS = %w(
        us-east-1
        us-west-2
        us-west-1
        eu-west-1
        eu-central-1
        ap-southeast-1
        ap-southeast-2
        ap-northeast-1
        sa-east-1
      )

      DEFAULT_OPTS = {
        regions: REGIONS
      }

      def initialize(client, opts = DEFAULT_OPTS)
        super(client)

        opts = DEFAULT_OPTS.merge(opts)

        @compute = {}
        opts[:regions].each do |region|
          compute_opts = {
            provider: 'AWS',
            aws_access_key_id: config['key'],
            aws_secret_access_key: config['secret'],
            region: region
          }

          @compute[region] = Fog::Compute.new(compute_opts)
        end

        self
      end

      def machines(force_refresh = false)
        if @machines.nil? || force_refresh
          klass = self.class.const_get('Machine')
          res = @compute.pmap do |_k, v|
            v.servers.all.to_a.map { |m| klass.new(self, v, m) }
          end
          @machines = res.reduce([], :+)
        end
        @machines
      end
    end
  end
end
