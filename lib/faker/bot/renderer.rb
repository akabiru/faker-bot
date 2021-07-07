# frozen_string_literal: true

require 'pastel'
require 'tty/pager'
require 'tty/screen'
require 'tty/tree'

require_relative 'emoji_store'

module Faker
  module Bot
    # A class responsible for printing output to an [IO] interface
    #
    # @api private
    #
    class Renderer
      DEPRECATION_WARNING = ' ( WILL BE DEPRECATED )'
      EMPTY = ''
      NOT_AVAILABLE = 'N/A'

      attr_reader :crayon, :hash, :options, :output, :pager

      def self.call(*args)
        new(*args).call
      end

      # Initialize a Render
      #
      # @param hash [Hash<Class => <Array<Symbol>>]
      # @param options [Hash]
      # @param output [IO]
      #
      # @api public
      #
      def initialize(hash, options, output)
        @hash = hash
        @options = options
        @output = output

        @crayon = Pastel.new(enabled: output.tty?)
        @pager = TTY::Pager.new(command: 'less -R')
      end

      # Print paginated output if the terminal interface supports pagination.
      # Otherwise, just print the full output
      #
      # @return [IO]
      #
      # @api private
      #
      def call
        if paginable?
          pager.page(render)
        else
          output.puts(render)
        end
      end

      # Render the structured data tree
      #
      # @return [String]
      #
      # @api private
      #
      def render
        tree.render
      end

      # Warm up the structured data tree render object
      #
      # @return [TTY<Tree>]
      #
      # @api private
      #
      def tree
        @tree ||= TTY::Tree.new(build_tree)
      end

      # Check whether the terminal interface supports pagination
      #
      # @return [Boolean]
      #
      # @api private
      #
      def paginable?
        gt_screen_height? && output.tty?
      end

      # Check whether the tree size is greater than current screen height
      #
      # @return [Boolean]
      #
      # @api private
      #
      def gt_screen_height?
        tree.nodes.size > TTY::Screen.height
      end

      private

      # Build the structured data tree sorted alphabetically
      #
      # @return [Hash{Class => <Array<Symbol>}]
      #
      # @api private
      #
      def build_tree
        results = hash.reduce({}) do |h, (const, methods)|
          h.merge! node(const, methods&.sort)
        end

        results.sort_by(&:to_s).to_h
      end

      # Tree node builder with color
      #
      # @return [Hash{Class => <Array<Symbol>}]
      #
      # @api private
      #
      def node(const, methods)
        emoji = EmojiStore.fetch(const.to_s)

        {
          "#{emoji}  #{crayon.green(const.to_s)}" => leaf(const, methods)
        }
      end

      # Tree leaf builder with color
      #
      # @return [Array<Symbol>]
      #
      # @api private
      #
      def leaf(const, methods)
        (methods || []).map { |m| crayon.cyan(*leaf_args(m, const)) }
      end

      def leaf_args(method, const)
        [method.to_s].tap do |arr|
          verbose_output(method, const, arr) if verbose?
        end
      end

      # Boolean verbose option flag
      #
      # @return [Boolean]
      #
      # @api private
      #
      def verbose?
        options[:verbose]
      end

      # Generate verbose output via sample fake data
      #
      # @return [Array<String>]
      #
      # @api private
      #
      def verbose_output(method, const, arr)
        fake, message = faker_method(method, const)

        arr.push(crayon.dim.white("=> #{fake}"))
           .push(crayon.dim.magenta.bold(message.to_s))
      end

      # Send message to Faker object; receive sample fake data
      #
      # @return [Array<String>]
      #
      # @api private
      #
      def faker_method(method, const)
        [
          const.public_send(method),
          ensure_method_is_supported(method, const)
        ]
      rescue ArgumentError => _e
        [NOT_AVAILABLE, EMPTY]
      end

      # Mark deprecated methods
      #
      # @return [String]
      #
      # @api private
      #
      def ensure_method_is_supported(method, const)
        if const.respond_to?(:"_deprecated_#{method}")
          DEPRECATION_WARNING
        else
          EMPTY
        end
      end
    end
  end
end
