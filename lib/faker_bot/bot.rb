require 'faker'

module FakerBot
  class Bot
    Faker::Base.class_eval do
      def self.descendants
        @descendants ||= ObjectSpace.each_object(Class).select do |klass|
          klass < self
        end
      end
    end

    class << self
      def find(query)
        faker_descendants.select { |faker| faker.match?(/#{query}/i) }
      end

      private

      def faker_descendants
        @faker_descendants ||= Faker::Base.descendants.map(&:to_s)
      end
    end
  end
end
