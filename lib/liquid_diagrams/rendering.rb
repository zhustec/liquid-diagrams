# frozen_string_literal: true

require 'open3'
require 'tempfile'
require 'tmpdir'

module LiquidDiagrams
  module Rendering
    module_function

    def render_with_stdin_stdout(command, content)
      render_with_command(command, :stdout, stdin_data: content)
    end

    def render_with_tempfile(command, content)
      input = Tempfile.new('input')
      output = Tempfile.new(%w[output .svg])

      File.write(input.path, content)

      extra = yield input.path, output.path
      command = "#{command} #{extra}"

      render_with_command(command, output.path)
    # TODO: recue Tempfile.new and File.write error
    ensure
      input.close!
      output.close!
    end

    def render_with_command(command, output = :stdout, **options)
      begin
        stdout, stderr, status = Open3.capture3(command, **options)
      rescue Errno::ENOENT
        raise Errors::CommandNotFoundError, command.split(' ')[0]
      end

      unless status.success?
        raise Errors::RenderingFailedError, <<~MSG
          #{command}: #{stderr.empty? ? stdout : stderr}
        MSG
      end

      output == :stdout ? stdout : File.read(output)
    end
  end
end
