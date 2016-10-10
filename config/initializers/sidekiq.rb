Sidekiq.configure_server do |config|
  config.redis = {
    url: Settings['sidekiq']['url'],
    namespace: Settings['sidekiq']['namespace']
  }
  config.server_middleware do |chain|
    chain.add Sidekiq::Middleware::Server::RetryJobs, :max_retries => Settings['sidekiq']['max_retries']
  end

  # Database pool should be at least `sidekiq_concurrency` + 2
  # For more info, see: https://github.com/mperham/sidekiq/blob/master/4.0-Upgrade.md
  ar_config = ActiveRecord::Base.configurations[Rails.env] ||
    Rails.application.config.database_configuration[Rails.env]
  ar_config['pool'] = Sidekiq.options[:concurrency] + 2
  ActiveRecord::Base.establish_connection(ar_config)
  Rails.logger.debug("Connection Pool size for Sidekiq Server is now: #{ActiveRecord::Base.connection.pool.instance_variable_get('@size')}")
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: Settings['sidekiq']['url'],
    namespace: Settings['sidekiq']['namespace']
  }
end