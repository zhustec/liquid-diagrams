# frozen_string_literal: true

require 'bundler/gem_helper'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task default: %i[spec]

Cucumber::Rake::Task.new(:features)

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop)

namespace :gem do
  Bundler::GemHelper.install_tasks
end
