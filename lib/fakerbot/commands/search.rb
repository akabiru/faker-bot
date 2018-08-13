# frozen_string_literal: true

require_relative '../command'

module FakerBot
  module Commands
    class Search < FakerBot::Command
      def initialize(options)
        @options = options
      end

      def execute(input, output: $stdout)
        render FakerBot::Bot.find(input), output
      end

      private

      def render(result, output)
        return not_found if result.empty?
        super(result, output)
      end

      def not_found
        puts "\nSorry, we couldn't find a match 😢", "\n"
      end
    end
  end
end
