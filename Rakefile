# frozen_string_literal: true

require 'bundler/gem_helper'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: %i[spec]

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop)

namespace :gem do
  Bundler::GemHelper.install_tasks
end
