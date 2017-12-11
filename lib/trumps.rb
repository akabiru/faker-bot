require 'faker'

class Object
  def my_singleton_methods
    super_klass = self.class.superclass

    return singleton_methods unless super_klass

    singleton_methods - super_klass.singleton_methods
  end
end

module Faker
  class Base
    class << self
      def descendants
        @_descendants ||= ObjectSpace.each_object(Class).select do |klass|
          klass < self
        end
      end
    end
  end
end
