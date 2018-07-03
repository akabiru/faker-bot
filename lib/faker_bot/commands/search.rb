# frozen_string_literal: true

require 'pastel'
require 'faker_bot/bot'

module FakerBot
  module Commands
    class Search
      def initialize(options)
        @options = options
      end

      def execute(input)
        result = FakerBot::Bot.find(input)
        puts(result.map { |r| Pastel.new.green(r) })
      end
    end
  end
end
