require 'fakerbot/commands/search'

RSpec.describe FakerBot::Commands::Search do
  let(:output) { StringIO.new }
  let(:options) { {} }
  let(:command) { described_class.new(options) }

  context 'when query object exists' do
    before do
      command.execute('image', output: output)
    end

    it 'returns results' do
      expect(output.string).to match(/Faker/)
      expect(output.string.lines.size).to be_positive
    end
  end

  context 'when query object does not exist' do
    before do
      command.execute('hasjdhaksjd', output: output)
    end

    it 'returns nil' do
      expect(output.string).to be_empty
    end
  end
end
