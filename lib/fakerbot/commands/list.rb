# frozen_string_literal: true

require_relative '../command'

module Fakerbot
  module Commands
    class List < FakerBot::Command
      def initialize(options)
        @options = options
      end

      def execute(output: $stdout)
        render FakerBot::Bot.list(verbose: @options[:verbose]), output
      end
    end
  end
end
