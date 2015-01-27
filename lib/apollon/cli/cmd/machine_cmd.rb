# encoding: utf-8

require 'gli'
require 'json'
require 'pp'
require 'terminal-table'

require_relative '../../client/client'
require_relative '../shared'

module Apollon
  # Apollon CLI
  module Cli
    client = Apollon::Client.new

    desc 'Machine(s) manager'
    command :machine do |c|
      c.desc 'List existing machines'
      c.command :list do |cmd|
        cmd.action do |global_options, options, args|
          args = args.nil? || args.empty? ? client.auth.providers_names : args
          res = []
          client.cluster.machines(args).each do |machine|
            res << machine.as_json
          end

          puts JSON.pretty_generate(res)
        end
      end
    end
  end
end