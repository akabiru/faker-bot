# frozen_string_literal: true

require 'faker/bot/commands/list'

RSpec.describe Faker::Bot::Commands::List do
  let(:output) { StringIO.new }
  let(:options) { {} }
  let(:command) { Faker::Bot::Commands::List.new(options) }

  context 'when single `list` command' do
    it 'executes successfully' do
      command.execute(output: output)
      expect(output.string).to match(/Faker/)
      expect(output.string.lines.size).to be_positive
    end

    context 'when passing a filter option' do
      let(:options) { super().merge(filter: filter) }

      context 'when the filter matches' do
        let(:filter) { 'Cannabis' }

        it 'executes successfully' do
          command.execute(output: output)
          expect(output.string).to match(/Faker/)
          expect(output.string.lines.size).to be_positive
        end
      end

      context 'when the filter does not match' do
        let(:filter) { 'foobar' }

        it 'returns a not found message' do
          command.execute(output: output)
          expect(output.string).to match(/Sorry, that class doesn't exist/)
        end
      end
    end
  end

  context 'when `list -v` verbose command' do
    let(:options) { { verbose: true } }

    it 'executes successfully' do
      command.execute(output: output)
      constant = output.string.lines[0]
      expect(constant).to match(/Faker::/)
    end
  end
end
