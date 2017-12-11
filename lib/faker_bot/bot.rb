require 'fuzzy_match'
require_relative 'descendants'

module FakerBot
  class Bot
    def initialize(matcher: FuzzyMatch)
      @matcher = matcher
    end

    def find(faker_const)
      fuzzy_matcher.find faker_const
    end

    private

    attr_reader :fuzzy_matcher

    def fuzzy_matcher
      @_fuzzy_matcher ||= @matcher.new FakerBot::FAKER_DESCENDANTS
    end
  end
end
