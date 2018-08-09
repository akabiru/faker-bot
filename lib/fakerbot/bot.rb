# frozen_string_literal: true

require 'faker'

module FakerBot
  class Bot
    Faker::Base.class_eval do
      def self.descendants
        @descendants ||= ObjectSpace.each_object(Class).select do |klass|
          klass < self
        end
      end

      def self.my_singleton_methods
        if superclass
          (singleton_methods - superclass.singleton_methods)
        else
          singleton_methods
        end
      end
    end

    class << self
      def find(query)
        search_descendants_matching(query)
        matching_descendants
      end

      private

      def search_descendants_matching(query)
        faker_descendants.each do |faker|
          methods = faker.my_singleton_methods
          matching = methods.select { |m| m.match?(/#{query}/i) }
          save_matching(faker, matching)
        end
      end

      def save_matching(descendant, matching)
        return if matching.empty?
        matching_descendants[descendant].concat(matching)
      end

      def matching_descendants
        @matching_descendants ||= Hash.new { |h, k| h[k] = [] }
      end

      def faker_descendants
        @faker_descendants ||= Faker::Base.descendants
      end
    end
  end
end
