# frozen_string_literal: true

RSpec.describe '`faker search` command', type: :cli do
  it 'executes `faker help search` command successfully' do
    output = `faker help search`
    expected_output = <<~OUT
Usage:
  faker search [Faker]

Options:
  -h, [--help], [--no-help], [--skip-help]                          # Display usage information
  -m, [--show-methods], [--no-show-methods], [--skip-show-methods]  # Display Faker constants with methods
                                                                    # Default: true
  -v, [--verbose], [--no-verbose], [--skip-verbose]                 # Include sample Faker output

Search Faker method(s)
    OUT
    expect(output).to match(expected_output)
  end

  context 'when search query exists' do
    it 'returns results' do
      output = `faker search name`
      expect(output).to match(/Faker::/)
      expect(output).to match(/└──/)
    end
  end

  context 'when search query does not exist' do
    it 'returns a not found message' do
      output = `faker search foobar`
      expect(output).to match(/Sorry, we couldn't find a match/)
    end
  end
end
