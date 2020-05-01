# frozen_string_literal: true

module LiquidDiagrams
  module Utils
    module_function

    # Join
    #
    # Examples
    #
    #   join('path', with: ' -I')
    #   # => ' -Ipath'
    #
    #   join(['path1', 'path2'], with: ' -I')
    #   # => ' -Ipath1 -Ipath2'
    #
    #   join({ color: 'red', size: '10' }, with: ' --') do |k, v|
    #     "#{k} #{v}"
    #   end
    #   # => ' --color red --size 10'
    def join(args, with:)
      args = Array(args)
      args = args.map { |arg| yield arg } if block_given?

      "#{with}#{args.join(with)}"
    end

    # Merge
    #
    # Examples
    #
    #   merge({ k1: 1, k2: 2}, { k1: 11, k3: 13})
    #   # => { k1: 11, k2: 2 }
    def merge(first, second)
      first.merge(second.slice(*first.keys))
    end

    def run_jar(jar)
      +"java -Djava.awt.headless=true -jar #{jar}"
    end

    def vendor_path(file = '')
      File.join(__dir__, '../../vendor', file)
    end
  end
end
