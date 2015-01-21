# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

# Copied from config.ru from latest middleman
require 'middleman-core/load_paths'
::Middleman.setup_load_paths

require 'middleman-core'
require 'middleman-core/rack'

require 'fileutils'
FileUtils.mkdir('log') unless File.exist?('log')
::Middleman::Logger.singleton("log/middleman_#{ENV['RACK_ENV']}.log")
ENV["MM_ROOT"] = "#{Rails.root}/public/middleman"
app = ::Middleman::Application.new
rack_app = ::Middleman::Rack.new(app).to_app

run Rack::URLMap.new "/middleman" => rack_app, "/" => Rails.application

