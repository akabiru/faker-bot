# frozen_string_literal: true

require_relative 'emoji_store/default'

module Faker
  module Bot
    module EmojiStore
      module_function

      def fetch(key)
        emojis.fetch(key) { ['🤷'] }.sample
      end

      def emojis
        EmojiStore::DEFAULT
      end
    end
  end
end
