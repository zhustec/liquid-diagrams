# frozen_string_literal: true

require 'simplecov-lcov'

LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.output_directory = 'coverage'
  c.lcov_file_name = 'lcov.info'
end

SimpleCov.start do
  enable_coverage :branch

  add_filter %r{^/features/}

  add_group 'Fundamental', %r{^/lib/liquid(_|-)diagrams(?:/\w+)?.rb}
  add_group 'Diagrams', %r{^/lib/liquid_diagrams/renderers/}
  add_group 'Specs', %r{^/spec/}

  formatter MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::LcovFormatter
  ])
end
