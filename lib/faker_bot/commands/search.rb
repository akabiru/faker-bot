# frozen_string_literal: true

require 'faker_bot/bot'

module FakerBot
  module Commands
    class Search
      def initialize(options)
        @options = options
      end

      def execute(input)
        result = FakerBot::Bot.find(input)
        puts result
      end
    end
  end
end
