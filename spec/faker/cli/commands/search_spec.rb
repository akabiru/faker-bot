# frozen_string_literal: true

require 'faker/cli/commands/search'

RSpec.describe Faker::CLI::Commands::Search do
  context 'when query object exists' do
    it 'returns results' do
      output = StringIO.new
      options = {}

      command = described_class.new(options)
      command.execute('image', output: output)

      expect(output.string).to match(/Faker/)
      expect(output.string.lines.size).to be_positive
    end
  end

  context 'when query object does not exist' do
    it 'returns a not found message' do
      output = StringIO.new
      options = {}

      command = described_class.new(options)
      command.execute('foobar', output: output)

      expect(output.string).to match(/Sorry, we couldn't find a match/)
    end
  end
end
