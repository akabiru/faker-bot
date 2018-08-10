# frozen_string_literal: true

require 'forwardable'
require 'pastel'
require 'tty/pager'
require 'tty/tree'

module FakerBot
  class Command
    extend Forwardable

    def_delegators :command, :run

    def pager
      TTY::Pager.new(command: 'less -R')
    end

    def screen
      TTY::Screen
    end

    def tree(input)
      TTY::Tree.new do
        input.each do |faker, methods|
          node Pastel.new.green(faker.to_s) do
            methods&.each { |m| leaf Pastel.new.cyan(m.to_s) }
          end
        end
      end
    end

    def render(result, output = $stdout)
      result_tree = tree(result)
      view = result_tree.render
      if screen.height < result_tree.nodes.size
        # paginate when attached to terminal
        output.tty? ? pager.page(view) : output.puts(view)
      else
        output.puts view
      end
    end
  end
end
