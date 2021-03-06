require 'simplecov'

SimpleCov.profiles.define 'custom' do
  load_profile 'test_frameworks'

  add_filter %r{^/config/}
  add_filter %r{^/db/}
  add_filter %r{^/vendor/}

  add_group 'Controllers', 'app/controllers'
  add_group 'Channels', 'app/channels' if defined?(ActionCable)
  add_group 'Models', 'app/models'
  add_group 'Mailers', 'app/mailers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Services', %w[app/services app/uploaders]
  add_group 'Jobs', %w[app/jobs app/workers]
  add_group 'Libraries', 'lib/'

  track_files '{app/**,lib,lib/bitcoin}/*.rb'
end

SimpleCov.start 'custom'
