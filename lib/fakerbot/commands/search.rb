# frozen_string_literal: true

require 'pastel'
require 'tty/pager'
require 'tty/tree'
require 'fakerbot/bot'

module FakerBot
  module Commands
    class Search
      def initialize(options)
        @options = options
        @pager = TTY::Pager.new(command: 'less -R')
        @screen = TTY::Screen
      end

      def execute(input)
        render FakerBot::Bot.find(input)
      end

      private

      attr_reader :screen, :pager

      def render(result)
        return not_found if result.empty?
        output = tree(result)
        if screen.height < output.nodes.size
          pager.page output.render
        else
          puts output.render
        end
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
        puts "\nSorry, we couldn't find a match 😢", "\n"
      end
    end
  end
end
