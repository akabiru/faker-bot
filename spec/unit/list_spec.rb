require 'fakerbot/commands/list'

RSpec.describe FakerBot::Commands::List do
  let(:output) { StringIO.new }
  let(:options) { {} }
  let(:command) { FakerBot::Commands::List.new(options) }

  before do
    command.execute(output: output)
  end

  context 'when single `list` command' do
    it 'executes successfully' do
      expect(output.string).to match(/Faker/)
      expect(output.string.lines.size).to be_positive
    end
  end

  context 'when `list -v` verbose command' do
    let(:options) { { verbose: true } }

    it 'executes successfully' do
      constant = output.string.lines[0]

      expect(constant).to match(/Faker::/)
    end
  end
end
