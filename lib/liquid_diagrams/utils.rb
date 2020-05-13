# frozen_string_literal: true

module LiquidDiagrams
  module Utils
    module_function

    # Join the args with prefix
    #
    # @param args [String, Array, Hash]
    # @param with [String]
    #
    # @yield When `args` is a Hash, you must provide a block
    # @yieldreturn [String] The result string to join
    #
    # @return [String]
    #
    # @example join on string
    #   join('path', with: ' -I')                     # => '-Ipath'
    #
    # @example join on array
    #   join(%w[path1 path2], with: ' -I')            # => '-Ipath1 -Ipath2'
    #
    # @example join on hash
    #   join({ color: 'red', size: '10' }, with: ' --') do |k, v|
    #     "#{k} #{v}"
    #   end                                           # => '--color red --size 10'
    def join(args, with:)
      args = Array(args)
      args = args.map { |arg| yield arg } if block_given?

      "#{with}#{args.join(with)}".strip
    end

    def build_options(config, keys, prefix: '--', sep: ' ')
      config.slice(*keys).map do |opt, val|
        "#{prefix}#{opt}#{sep}#{val}"
      end.join(' ').strip
    end

    def build_flags(config, keys, prefix: '--')
      config.slice(*keys).map do |flag, val|
        "#{prefix}#{flag}" if val
      end.join(' ').strip
    end

    def run_jar(jar)
      "java -Djava.awt.headless=true -jar #{jar}"
    end

    def vendor_path(file = '')
      File.join(__dir__, '../../vendor', file)
    end

    INLINE_OPTIONS_SYNTAX = /^\s*(?:(\w+)=(\w+|"[^"]+")\s+)*\s*$/.freeze
    INLINE_OPTIONS_REGEXP = /(?:(\w+)=(\w+|"[^"]+"))/.freeze

    def parse_inline_options(input)
      options = {}

      input.scan(INLINE_OPTIONS_REGEXP) do |key, value|
        value.delete!('"') if value.include?('"')

        options[key.to_s] = value
      end

      options
    end
  end
end
