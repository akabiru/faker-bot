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
      data_tree = hash.reduce({}) do |h, (faker, methods)|
        h.merge! node(faker, methods&.sort)
      end
      data_tree.sort_by(&:to_s).to_h
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
      [method.to_s].tap do |arr|
        if verbose?
          fake = begin
            const.public_send(method)
          rescue ArgumentError
            'N/A'
          end
          arr << crayon.dim.white("=> #{fake.to_s}")
        end
      end
    end

    def gt_screen_height?(data_tree)
      data_tree.nodes.size > screen.height
    end

    def verbose?
      options[:verbose]
    end
  end
end
