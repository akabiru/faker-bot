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

    attr_reader :descendants_with_methods, :query

    def initialize(query = nil)
      @descendants_with_methods = Hash.new { |h, k| h[k] = [] }
      @query = query
    end

    class << self
      def find(query)
        new(query).find
      end

      def list(verbose: false)
        new.list(verbose)
      end
    end

    def find
      search_descendants_matching_query
      descendants_with_methods
    end

    def list(verbose)
      faker_descendants.each do |faker|
        methods = verbose ? faker.my_singleton_methods : []
        store(faker, methods)
      end
      descendants_with_methods
    end

    private

    def search_descendants_matching_query
      faker_descendants.each do |faker|
        methods = faker.my_singleton_methods
        matching = methods.select { |m| m.match?(/#{query}/i) }
        store(faker, matching)
      end
    end

    def store(descendant, matching)
      return if matching.empty?
      descendants_with_methods[descendant].concat(matching)
    end

    def faker_descendants
      @faker_descendants ||= Faker::Base.descendants
    end
  end
end
