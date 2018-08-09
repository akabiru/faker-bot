# frozen_string_literal: true

require 'pastel'
require 'tty/tree'
require 'fakerbot/bot'

module FakerBot
  module Commands
    class Search
      def initialize(options)
        @options = options
      end

      def execute(input)
        result = FakerBot::Bot.find(input)
        puts result.empty? ? not_found : tree(result).render
      end

      def tree(input)
        TTY::Tree.new do
          input.each do |faker, methods|
            node Pastel.new.green(faker.to_s) do
              methods.each { |m| leaf Pastel.new.cyan(m.to_s) }
            end
          end
        end
      end

      def not_found
        "\n ☹️ Sorry, we couldn't find a match\n"
      end
    end
  end
end