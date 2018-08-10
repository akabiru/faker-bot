# frozen_string_literal: true

require 'fakerbot/bot'

module FakerBot
  module Commands
    class Search < FakerBot::Command
      def initialize(options)
        @options = options
      end

      def execute(input)
        render FakerBot::Bot.find(input)
      end

      private

      def render(result)
        return not_found if result.empty?
        super
      end

      def not_found
        puts "\nSorry, we couldn't find a match 😢", "\n"
      end
    end
  end
end
