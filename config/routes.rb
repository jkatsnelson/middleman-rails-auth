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

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  authenticate :user do
    mount ::Middleman::Rack.new(app) => '/'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
