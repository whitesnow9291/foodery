require 'dotenv'
Dotenv.load

Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.assets.debug = true
  config.assets.digest = true
  config.assets.raise_runtime_errors = true
  config.action_mailer.default_url_options = { host: 'localhost:3000' }

  config.logger = Logger.new(STDOUT)


  #config.active_record.logger = nil


  # config.paperclip_defaults = {
  #   :storage => :s3,
  #   :s3_protocol => :https,
  #   :s3_credentials => {
  #     :bucket => ENV['S3_BUCKET_NAME'],
  #     :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
  #     :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  #   }
  # }
end
