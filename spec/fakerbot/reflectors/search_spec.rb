# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FakerBot::Reflectors::Search do
  describe '#call' do
    context 'when a match is found' do
      it 'it returns the list of matches' do
        query = 'firstname'

        reflector = described_class.new(query)
        result = reflector.call

        expect(result[Faker::Name]).to include(:first_name)
        expect(result).to be_a(Hash)
      end
    end

    context 'when no match is found' do
      it 'returns an empty hash' do
        query = 'foobar'

        reflector = described_class.new(query)
        result = reflector.call

        expect(result).to be_empty
        expect(result).to be_a(Hash)
      end
    end
  end
end
