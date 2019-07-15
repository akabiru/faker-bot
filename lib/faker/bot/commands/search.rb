# frozen_string_literal: true

require_relative '../command'
require_relative '../reflectors/search'

module Faker
  module Bot
    module Commands
      # Runs a search against [Faker<Base>] methods and returns matching results
      #
      # @api private
      #
      class Search < Command
        # Execute the `search` command
        #
        # @return [IO]
        #
        # @api private
        #
        def execute(input, output: $stdout)
          result = Reflectors::Search.call(input)
          render(result, output)
        end

        private

        # Render the search results
        #  * Return #not_found when there're no matching results
        #
        # @param result [Hash] the render tree
        # @param output [IO]
        #
        # @return [IO]
        #
        # @api private
        #
        def render(result, output)
          return not_found(output) if result.empty?

          super(result, output)
        end

        # Render a bespoke "not found" message
        #
        # @param output [IO]
        #
        # @return [IO]
        #
        # @api private
        #
        def not_found(output)
          output.puts "\nSorry, we couldn't find a match 😢", "\n"
        end
      end
    end
  end
end
