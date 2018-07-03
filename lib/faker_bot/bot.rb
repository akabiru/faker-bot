require 'fuzzy_match'

module FakerBot
  class Bot
    class Object
      def descendants
        @descendants ||= ObjectSpace.each_object(Class).select do |klass|
          klass < self
        end
      end
    end

    def initialize(matcher: FuzzyMatch)
      @matcher = matcher
    end

    def find(faker_const)
      fuzzy_matcher.find faker_const
    end

    private

    def fuzzy_matcher
      @fuzzy_matcher ||= @matcher.new(FakerBot::FAKER_DESCENDANTS)
    end

    def faker_descendants
      @faker_descendants ||= Faker::Base.descendants
    end
  end
end
