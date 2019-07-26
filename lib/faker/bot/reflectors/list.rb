# frozen_string_literal: true

require_relative '../reflector'

module Faker
  module Bot
    module Reflectors
      # List command reflector
      # @api private
      #
      class List < Reflector
        attr_reader :filter
        attr_reader :show_methods

        def self.call(options)
          new(options).call
        end

        def initialize(options = {})
          @filter = options[:filter]
          @show_methods = options[:show_methods]

          super
        end

        def call
          show_methods ? list_descendants_with_methods : list_descendants
        end

        private

        def list_descendants_with_methods
          list_descendants
          descendants_with_methods
        end

        def list_descendants
          faker_descendants.each do |descendant|
            if filter_matches_class_name?(descendant.to_s)
              store(descendant, descendant.my_singleton_methods)
            end
          end
          descendants_with_methods.keys
        end

        def filter_matches_class_name?(class_name)
          return true unless filter
          class_name.match(/#{filter}/)
        end
      end
    end
  end
end
