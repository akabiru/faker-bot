# frozen_string_literal: true

require 'forwardable'

require_relative 'renderer'

module Faker
  module Bot
    class Command
      extend Forwardable

      def_delegators :command, :run
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def render(result, output)
        Renderer.call(result, options, output)
      end
    end
  end
end
