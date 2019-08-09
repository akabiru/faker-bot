# frozen_string_literal: true

require_relative '../reflector'

module Faker
  module Bot
    module Reflectors
      # Reflection object that lists all `Faker::Base` subclasses
      #
      # @api private
      #
      class List < Reflector
        # Output filter
        #
        # @return [String, nil]
        #
        # @api private
        #
        attr_reader :filter
        # Boolean flag on whether to list methods or not
        #
        # @return [Boolean, nil]
        #
        # @api private
        #
        attr_reader :show_methods

        # Initialize list reflector
        #
        # @param options [Hash{Symbol => Boolean, nil}] Reflector options
        # @option options [Boolean, nil] :show_method
        #   Show methods in listing boolean flag
        #
        # @api public
        #
        def initialize(options = {})
          @filter = options[:filter]
          @show_methods = options[:show_methods]

          super
        end

        # List `Faker::Base` subclasses
        #
        # @return [Hash<Class => <Array<Symbol>>] when #show_methods is truthy
        #
        # @api private
        #
        def call
          if show_methods
            list_descendants_with_methods
          else
            list_descendants
          end
        end

        private

        # List `Faker::Base` subclasses with methods
        #
        # @return [Hash{Class => <Array<Symbol>}]
        #
        # @api private
        #
        def list_descendants_with_methods
          list_descendants
          descendants_with_methods
        end

        # List `Faker::Base` subclasses
        #
        # @return [Array<Class>]
        #
        # @api private
        #
        def list_descendants
          faker_descendants.each do |descendant|
            if filter_matches_class_name?(descendant.to_s)
              store(descendant, descendant.my_singleton_methods)
            end
          end
          descendants_with_methods.keys
        end

        # Match against class name when filter is defined
        #
        # @return [Boolean]
        #
        # @api private
        #
        def filter_matches_class_name?(class_name)
          return true unless filter

          class_name.match(/#{filter}/i)
        end
      end
    end
  end
end
