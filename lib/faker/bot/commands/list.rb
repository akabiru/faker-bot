# frozen_string_literal: true

require_relative '../command'
require_relative '../reflectors/list'

module Faker
  module Bot
    module Commands
      # Lists all [Faker<Base>] constants
      #
      # @api private
      #
      class List < Command
        # Execute the `list` command
        #
        # @return [IO]
        #
        # @api private
        #
        def execute(output: $stdout)
          result = Reflectors::List.call(options)
          render(result, output)
        end

        private

        def render(result, output)
          return not_found(output) if result.empty?

          super(result, output)
        end

        def not_found(output)
          output.puts "\nSorry, that class doesn't exist 😢", "\n",
                      'Try something like `Faker::Beer` or `Beer`.', "\n"
        end
      end
    end
  end
end
