# frozen_string_literal: true

require 'thor'
require 'fakerbot/cli'
require 'fakerbot/version'
require 'fakerbot/commands/list'
require 'fakerbot/commands/search'

module FakerBot
  class CLI < Thor
    Error = Class.new(StandardError)

    desc 'version', 'fakerbot version'
    def version
      require_relative 'version'
      puts "v#{FakerBot::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'list', 'List all Faker constants'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    method_option :verbose, aliases: '-v', type: :boolean,
                            desc: 'Display Faker constants with methods'
    def list(*)
      if options[:help]
        invoke :help, ['list']
      else
        FakerBot::Commands::List.new(options).execute
      end
    end

    desc 'search [Faker]', 'Search Faker method(s)'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    method_option :verbose, aliases: '-v', type: :boolean,
                            desc: 'Display Faker constants methods with examples'
    def search(query)
      if options[:help]
        invoke :help, ['search']
      else
        FakerBot::Commands::Search.new(options).execute(query)
      end
    end
  end
end
