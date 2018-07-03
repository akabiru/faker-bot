# frozen_string_literal: true

require 'thor'
require 'faker_bot/cli'
require 'faker_bot/version'
require 'faker_bot/commands/search'

module FakerBot
  class CLI < Thor
    Error = Class.new(StandardError)

    desc 'version', 'faker_bot version'
    def version
      require_relative 'version'
      puts "v#{FakerBot::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'search', 'Search Faker method(s)'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def search(query)
      if options[:help]
        invoke :help, ['search']
      else
        FakerBot::Commands::Search.new(options).execute(query)
      end
    end
  end
end
