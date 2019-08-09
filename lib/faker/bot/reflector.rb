# frozen_string_literal: true

require 'faker'

module Faker
  module Bot
    # @abstract `Faker::Base` Reflection object
    # * Introspects the `Faker::Base` class and it's descendants
    #
    # @api private
    #
    class Reflector
      Faker::Base.class_eval do
        # Skip default deprecation warning output; the CLI will display that.
        Gem::Deprecate.skip = true

        # Select [Faker<Base>] subclasses
        #
        # @return [Array<Class>] `Faker::Base` subclasses
        #
        # @api private
        #
        def self.descendants
          @descendants ||= ObjectSpace.each_object(Class).select do |klass|
            klass < self
          end
        end

        # Select public class methods
        #
        # @return [Array] singleton public methods
        #
        # @api private
        #
        def self.my_singleton_methods
          singleton_methods(false).select { |m| respond_to?(m) }
        end
      end

      # @example Faker::Base subclasses with their methods
      #   { Faker::Marketing => [:buzzwords], Faker::Artist => [:name] }
      #
      # @return [Hash[Class => [Array<Symbol>]]
      #
      # @api private
      #
      attr_reader :descendants_with_methods

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

      # Initialize the reflector
      #
      # @api public
      #
      def initialize(*)
        @descendants_with_methods = Hash.new { |h, k| h[k] = [] }
      end

      protected

      # Adds a `Faker::Base` descendant methods to the method list
      #
      # @param descendant [Class] The `Faker::Base` subclass
      # @param methods [Array<Symbol>] The `Faker::Base` subclass methods
      #
      # @return [Array<Symbol>]
      #
      # @api private
      #
      def store(descendant, methods)
        return if methods.empty?

        descendants_with_methods[descendant].concat(methods)
      end

      # Get all `Faker::Base` subclasses
      #
      # @return [Array<Class>]
      #
      # @api public
      #
      def faker_descendants
        @faker_descendants ||= Faker::Base.descendants
      end
    end
  end
end
