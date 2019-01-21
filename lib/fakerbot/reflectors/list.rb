# frozen_string_literal: true

require_relative '../reflector'

module FakerBot
  module Reflectors
    # List command reflector
    # @api private
    #
    class List < FakerBot::Reflector
      def self.call(show_methods: false)
        new.call(show_methods)
      end

      def call(show_methods)
        show_methods ? all_descendants_with_methods : faker_descendants
      end

      private

      def all_descendants_with_methods
        faker_descendants.each do |faker|
          store(faker, faker.my_singleton_methods)
        end
        descendants_with_methods
      end
    end
  end
end
