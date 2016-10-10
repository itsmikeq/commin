class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

  # TODO: Mix in all of the ENV variables for secrets, etc.
  Settings['sidekiq'] ||= Settingslogic.new({})
  Settings['sidekiq']['max_retries'] ||= 10
  Settings['sidekiq']['url'] ||= 'redis://localhost:6379'
  Settings['sidekiq']['namespace'] ||= "#{Rails.application.engine_name}_#{Rails.env}"

  Settings['elasticsearch'] ||= Settingslogic.new({})
  Settings['elasticsearch']['urls'] ||= ["http://localhost:9200"]
  # ES Logging.  noisy.  turn off in production/test
  Settings['elasticsearch']['log'] ||= Rails.env.development?
end