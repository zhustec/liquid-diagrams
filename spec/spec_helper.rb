# frozen_string_literal: true

require 'bundler/setup'

require 'deep_cover/builtin_takeover'
require 'simplecov'
require 'pry-byebug'

require 'liquid-diagrams'

format = ENV['CI'] ? 'progress' : 'documentation'

RSpec.configure do |config|
  config.formatter = format

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Dir[File.join(__dir__, 'support/*.rb')].sort.each { |file| require file }
