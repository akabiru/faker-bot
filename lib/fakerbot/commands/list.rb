# frozen_string_literal: true

require_relative '../command'

module FakerBot
  module Commands
    class List < FakerBot::Command
      def initialize(options)
        @options = options
      end

      def execute(output: $stdout)
        result = FakerBot::Reflector.list(show_methods: options[:show_methods])
        render result, output
      end
    end
  end
end
