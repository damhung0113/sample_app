require_relative "boot"
require "rails/all"

module SampleApp
  class Application < Rails::Application
    Bundler.require *Rails.groups
    Config::Integrations::Rails::Railtie.preload
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :en
    config.load_defaults 5.2
  end
end
