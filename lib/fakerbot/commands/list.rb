# frozen_string_literal: true

require_relative '../command'

module Fakerbot
  module Commands
    class List < FakerBot::Command
      def initialize(options)
        @options = options
      end

      def execute
        render FakerBot::Bot.list(verbose: @options[:verbose])
      end
    end
  end
end
