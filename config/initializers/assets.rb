# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version    = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
# Rails.application.config.assets.precompile += Dir[Rails.root.join('app/assets/javascripts/**/*')]
Rails.root.join('vendor', 'assets', 'components').to_s.tap do |bower_path|
  Rails.application.config.sass.load_paths << bower_path
  Rails.application.config.assets.paths << bower_path
end

# Rails.application.config.assets.paths << Rails.root.join('app/assets/javascripts').to_s

# Precompile Bootstrap fonts
Rails.application.config.assets.precompile << %r(bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$)

Dir[Rails.root.join('vendor', 'assets', 'components', '**', '*').to_s].each do |_path|
  if _path.end_with?('\.css') || _path.match(%r([\w-]+\.(?:eot|svg|ttf|woff2?)$))
    Rails.application.config.assets.precompile _path
  end
end
# Minimum Sass number precision required by bootstrap-sass
::Sass::Script::Value::Number.precision = [8, ::Sass::Script::Value::Number.precision].max

Rails.application.configure do
  # Settings for the pool of renderers:
  config.react.server_renderer_pool_size  ||= 1  # ExecJS doesn't allow more than one on MRI
  config.react.server_renderer_timeout    ||= (Rails.env.production? ? 10 : 20) # seconds
  config.react.server_renderer = React::ServerRendering::SprocketsRenderer
  config.react.server_renderer_options = {
    files: ["react-server.js", "components.js"], # files to load for prerendering
    replay_console: true,                 # if true, console.* will be replayed client-side
  }
end