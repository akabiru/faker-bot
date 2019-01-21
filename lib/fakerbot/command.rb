# frozen_string_literal: true

require 'forwardable'

require_relative 'renderer'

module FakerBot
  class Command
    extend Forwardable

    def_delegators :command, :run
    attr_reader :options

    def render(result, output)
      Renderer.call(result, options, output)
    end
  end
end
