RSpec.describe FakerBot::Reflector do
  subject(:reflector) { described_class }

  describe '.find' do
    context 'when a match is found' do
      let(:result) { reflector.find('firstname') }

      it 'it returns the list of matches' do
        expect(result[Faker::Name]).to include(:first_name)
        expect(result).to be_a(Hash)
      end
    end

    context 'when no match is found' do
      it 'returns an empty array' do
        expect(reflector.find('foobar')).to be_empty
      end
    end
  end
end
