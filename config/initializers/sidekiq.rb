# frozen_string_literal: true

Sidekiq.configure_client do |config|
  config.redis = { db: Rails.application.secrets.redis_db }
end

Sidekiq.configure_server do |config|
  config.on :startup do
    Rails.logger = Sidekiq::Logging.logger
  end
  config.redis = { db: Rails.application.secrets.redis_db }
end
