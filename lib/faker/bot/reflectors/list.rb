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
        attr_reader :filter
        # Boolean flag on whether to list methods or not
        #
        # @return [Boolean, nil]
        #
        # @api private
        #
        attr_reader :show_methods

        # Alternate constructor
        #
        # @see #initialize
        # @see #call
        #
        # @api public
        #
        def self.call(*args)
          new(*args).call
        end

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
        # @return [Hash{Class => <Array<Symbol>}] when #show_methods is truthy
        # @return [Array<Class>] when #show_methods is falsy
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

        def list_descendants_with_methods
          list_descendants
          descendants_with_methods
        end

        # List `Faker::Base` subclasses
        #
        # @return [Hash{Class => <Array<Symbol>}]
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

        def filter_matches_class_name?(class_name)
          return true unless filter

          class_name.match(/#{filter}/i)
        end
      end
    end
  end
end
