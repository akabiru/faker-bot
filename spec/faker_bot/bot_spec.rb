RSpec.describe FakerBot::Bot do
  subject(:bot) { described_class }

  describe '.find' do
    context 'when a match is found' do
      it 'it returns the list of matches' do
        expect(bot.find('name')).to match(
          %w[Faker::Name Faker::FunnyName]
        )
      end
    end

    context 'when no match is found' do
      it 'returns an empty array' do
        expect(bot.find('foobar')).to be_empty
      end
    end
  end
end
