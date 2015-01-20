# encoding: utf-8

require 'gli'

include GLI::App

require_relative '../../version'

require_relative '../shared'

desc 'Print version info'
command :version do |cmd|
  cmd.action do |_global_options, _options, _args|
    pp Apollon::VERSION
  end
end