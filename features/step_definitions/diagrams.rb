# frozen_string_literal: true

Given('I have a liquid template with:') do |content|
  @content = content
end

When('I render it') do
  @output = render_liquid(@content)
end

When('I render it with {string} options:') do |key, options|
  @output = render_liquid(@content, key.to_sym => Hash[options.raw])
end

Then('the output should contains {string}') do |pattern|
  expect(@output).to match Regexp.new(pattern)
end

Then('the output should not contains {string}') do |pattern|
  expect(@output).not_to match Regexp.new(pattern)
end
