# frozen_string_literal: true

require 'forwardable'
require_relative 'reflector'
require_relative 'renderer'

module FakerBot
  class Command
    extend Forwardable

    def_delegators :command, :run
    attr_reader :options

    def render(result, output)
      FakerBot::Renderer.call(result, options, output)
    end
  end
end
