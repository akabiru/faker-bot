# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Faker::Bot::Reflectors::Search do
  describe '#call' do
    let(:result) { described_class.new(query).call }

    context 'when passing a full method name' do
      let(:query) { 'first_name' }

      it 'it returns the list of matches' do
        expect(result[Faker::Name]).to include(:first_name)
        expect(result).to be_a(Hash)
      end
    end

    context 'when passing a partial method name' do
      let(:query) { 'fir' }

      it 'returns the list of matches' do
        expect(result[Faker::Name]).to include(:first_name)
        expect(result).to be_a(Hash)
      end
    end

    context 'when passing a full class name' do
      let(:query) { 'Beer' }

      it 'returns the list of matches' do
        expect(result).to include(Faker::Beer)
        expect(result).to be_a(Hash)
      end
    end

    context 'when passing a partial class name' do
      let(:query) { 'bee' }

      it 'returns the list of matches' do
        expect(result).to include(Faker::Beer)
        expect(result).to be_a(Hash)
      end
    end

    context 'when no match is found' do
      let(:query) { 'firstname'}

      it 'returns an empty hash' do
        expect(result).to be_empty
        expect(result).to be_a(Hash)
      end
    end
  end
end
