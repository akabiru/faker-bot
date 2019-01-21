# frozen_string_literal: true

require_relative '../reflector'

module FakerBot
  module Reflectors
    # List command reflector
    # @api private
    #
    class List < FakerBot::Reflector
      attr_reader :show_methods

      def self.call(options)
        new(options).call
      end

      def initialize(options = {})
        @show_methods = options[:show_methods]

        super
      end

      def call
        show_methods ? all_descendants_with_methods : faker_descendants
      end

      private

      def all_descendants_with_methods
        faker_descendants.each do |descendant|
          store(descendant, descendant.my_singleton_methods)
        end
        descendants_with_methods
      end
    end
  end
end
