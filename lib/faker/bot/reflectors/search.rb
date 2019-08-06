# frozen_string_literal: true

require_relative '../reflector'

module Faker
  module Bot
    module Reflectors
      # Reflection object that searches all `Faker::Base` subclass methods
      #  * Currently operates at O(n); improvements welcome. :)
      #
      # @api private
      #
      class Search < Reflector
        # Reflector query
        #
        # @return [String, nil]
        #
        # @api private
        #
        attr_reader :query

        # Initialize search reflector
        #
        # @param query [String] The search query
        #
        # @api public
        #
        def initialize(query)
          @query = query.downcase

          super
        end

        # Search through `Faker::Base` subclasses and return matching results
        #
        # @return [Hash<Class => <Array<Symbol>>] when #show_methods is truthy
        #
        # @api private
        #
        def call
          search_descendants_matching_query
          descendants_with_methods
        end

        private

        # Search through `Faker::Base` subclasses and store matching results
        #
        # @api private
        #
        def search_descendants_matching_query
          faker_descendants.each do |descendant|
            methods = descendant.my_singleton_methods

            if query_matches?(descendant)
              store(descendant, methods)
            else
              store(
                descendant,
                methods.select { |method| query_matches?(method) }
              )
            end
          end
        end

        # Match a subject against the query string
        #
        # @return [Boolean]
        #
        # @api private
        #
        def query_matches?(subject)
          subject.to_s.match(/#{query}/i)
        end
      end
    end
  end
end
