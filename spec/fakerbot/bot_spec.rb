RSpec.describe FakerBot::Bot do
  subject(:bot) { described_class }

  describe '.find' do
    context 'when a match is found' do
      let(:result) { bot.find('name') }

      it 'it returns the list of matches' do
        expect(result).to include('Faker::Name')
        expect(result).to be_a(Array)
      end
    end

    context 'when no match is found' do
      it 'returns an empty array' do
        expect(bot.find('foobar')).to be_empty
      end
    end
  end
end
