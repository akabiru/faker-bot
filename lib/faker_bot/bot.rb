require 'faker'
require 'fuzzy_match'

module FakerBot
  class Bot
    Faker::Base.class_eval do
      def self.descendants
        @descendants ||= ObjectSpace.each_object(Class).select do |klass|
          klass < self
        end
      end
    end

    def initialize(matcher: FuzzyMatch)
      @matcher = matcher
    end

    class << self
      def find(query)
        new.find(query)
      end
    end

    def find(faker_const)
      fuzzy_matcher.find(faker_const)
    end

    private

    def fuzzy_matcher
      @fuzzy_matcher ||= @matcher.new(faker_descendants)
    end

    def faker_descendants
      @faker_descendants ||= Faker::Base.descendants
    end
  end
end
