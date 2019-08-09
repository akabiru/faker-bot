# frozen_string_literal: true

require 'forwardable'

require_relative 'renderer'

module Faker
  module Bot
    # @abstract interface for [Command] objects
    #
    # @api private
    #
    class Command
      extend Forwardable

      def_delegators :command, :run

      # [Command] options
      #
      # @return [Hash<Symbol, String => String, Boolean>]
      #
      # @api private
      #
      attr_reader :options

      # Initialize the command
      #
      # @param options [Hash<Symbol, String => String, Boolean>]
      #   The command options
      #
      # @api public
      #
      def initialize(options)
        @options = options
      end

      # Render the command result into [IO]
      #
      # @param result {Hash} the render tree
      # @param output [IO]
      #
      # @return [IO]
      #
      # @api private
      #
      def render(result, output)
        Renderer.call(result, options, output)
      end
    end
  end
end
