# frozen_string_literal: true

require 'pastel'
require 'tty/pager'
require 'tty/screen'
require 'tty/tree'

module FakerBot
  class Renderer
    def self.call(hash, options, output)
      new(hash, options, output).call
    end

    def initialize(hash, options, output)
      @hash = hash
      @options = options
      @output = output
      @crayon = Pastel.new(enabled: output.tty?)
      @pager = TTY::Pager.new(command: 'less -R')
      @screen = TTY::Screen
      @tree = TTY::Tree
    end

    def call
      data_tree = tree.new(build_tree)
      view = data_tree.render
      if gt_screen_height?(data_tree)
        output.tty? ? pager.page(view) : output.puts(view)
      else
        output.puts view
      end
    end

    private

    attr_reader :crayon, :hash, :options, :output, :pager, :screen, :tree

    def build_tree
      hash.reduce({}) do |h, (faker, methods)|
        h.merge! node(faker, methods)
      end
    end

    def node(const, methods)
      {
        crayon.green(const.to_s) => leaf(const, methods)
      }
    end

    def leaf(const, methods)
      (methods || []).map do |m|
        crayon.cyan(*leaf_args(m, const))
      end
    end

    def leaf_args(method, const)
      [method.to_s].tap { |arr| verbose_output(method, const, arr) if verbose? }
    end

    def gt_screen_height?(data_tree)
      data_tree.nodes.size > screen.height
    end

    def verbose?
      options[:verbose]
    end

    def verbose_output(method, const, arr)
      fake, message = faker_method(method, const)
      arr << crayon.dim.white("=> #{fake.to_s}") << crayon.dim.magenta.bold("#{message}")
    end

    def faker_method(method, const)
      [const.public_send(method), ensure_method_is_supported(method, const)]
    rescue ArgumentError
      ['N/A', '']
    end

    def ensure_method_is_supported(method, const)
      const.respond_to?(:"_deprecated_#{method.to_s}") ? ' ( WILL BE DEPRECATED )' : ''
    end
  end
end
