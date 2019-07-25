# frozen_string_literal: true

require_relative '../reflector'

module Faker
  module Bot
    module Reflectors
      # Reflection object that searches all `Faker::Base` subclass methods
      #
      # @api private
      #
      class Search < Reflector
        attr_reader :query

        def initialize(query)
          @query = query.downcase

          super
        end

        def call
          search_descendants_matching_query
          descendants_with_methods
        end

        private

        def search_descendants_matching_query
          faker_descendants.each do |descendant|
            methods = descendant.my_singleton_methods
            if query_matches_class_name?(descendant.to_s)
              store(descendant, methods)
            else
              store(descendant, methods.select { |method| query_matches_method?(method.to_s) })
            end
          end
        end

        def query_matches_method?(method_name)
          method_name.match(/#{query}/)
        end

        def query_matches_class_name?(class_name)
          class_name.downcase.match(/#{query}/)
        end
      end
    end
  end
end
