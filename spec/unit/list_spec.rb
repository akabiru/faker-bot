require 'fakerbot/commands/list'

RSpec.describe Fakerbot::Commands::List do
  let(:output) { StringIO.new }
  let(:options) { {} }
  let(:command) { Fakerbot::Commands::List.new(options) }

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
      method = output.string.lines[1]

      expect(constant).to match(/Faker::/)
      expect(method).not_to match(/Faker::/)
      expect(method).to match(/└──/)
    end
  end
end
