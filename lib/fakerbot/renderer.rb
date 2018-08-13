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
        args = [m.to_s].tap do |a|
          if show_examples?
            fake = begin
              const.public_send(m)
            rescue ArgumentError
              'N/A'
            end
            a << pastel.dim.white("=> #{fake.to_s}")
          end
        end
        crayon.cyan(*args)
      end
    end

    def gt_screen_height?(data_tree)
      data_tree.nodes.size > screen.height
    end

    def show_examples?
      options[:show_examples]
    end
  end
end
