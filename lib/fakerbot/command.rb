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

    def render(result)
      output = tree(result)
      if screen.height < output.nodes.size
        pager.page output.render
      else
        puts output.render
      end
    end
  end
end
