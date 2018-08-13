# frozen_string_literal: true

require_relative '../command'

module FakerBot
  module Commands
    class List < FakerBot::Command
      def initialize(options)
        @options = options
      end

      def execute(output: $stdout)
        render FakerBot::Reflector.list(verbose: @options[:verbose]), output
      end
    end
  end
end
