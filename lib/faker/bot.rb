# frozen_string_literal: true

require 'thor'

require 'faker/bot/commands/list'
require 'faker/bot/commands/search'
require 'faker/bot/version'

module Faker
  module Bot
    class Base < Thor
      Error = Class.new(StandardError)

      desc 'version', 'Faker version'
      def version
        puts "v#{Faker::Bot::VERSION}"
      end
      map %w[--version -v] => :version

      desc 'list', 'List all Faker constants'
      method_option :help, aliases: '-h', type: :boolean,
                           desc: 'Display usage information'
      method_option :show_methods, aliases: '-m', type: :boolean, default: true,
                                   desc: 'Display Faker constants with methods'
      method_option :verbose, aliases: '-v', type: :boolean,
                              desc: 'Include sample Faker output'
      def list(filter = nil)
        if options[:help]
          invoke :help, ['list']
        else
          filter_options = options.merge(filter: filter)
          Faker::Bot::Commands::List.new(filter_options).execute
        end
      end

      desc 'search [Faker]', 'Search Faker method(s)'
      method_option :help, aliases: '-h', type: :boolean,
                           desc: 'Display usage information'
      method_option :show_methods, aliases: '-m', type: :boolean, default: true,
                                   desc: 'Display Faker constants with methods'
      method_option :verbose, aliases: '-v', type: :boolean,
                              desc: 'Include sample Faker output'
      def search(query)
        if options[:help]
          invoke :help, ['search']
        else
          Faker::Bot::Commands::Search.new(options).execute(query)
        end
      end
    end
  end
end
