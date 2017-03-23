require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HelloRails
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # bootstrap対応で追記 Railstutorial 5.1.2
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.bmp)

    # Viewの描画ログを出力しない
    config.action_view.logger = nil

    # デフォルトのテンプレートエンジン
    config.generators.template_engine = :haml

    # ジェネレーターで作成されるものを絞り込む ※実践RoR4 p.58
    config.generators do |g|
      g.helper false  # ヘルパー
      g.assets false  # SCSS/CoffeeScriptファイル
      g.test_framework :rspec   # デフォルトはMiniTest
      g.controller_specs false
      g.view_specs false
    end


    # assetsへのアクセスログを抑止するgem "quiet_assets" を使う?
    # config.quiet_assets = false

  end
end
