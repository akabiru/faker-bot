# frozen_string_literal: true

RSpec.describe '`fakerbot search` command', type: :cli do
  it 'executes `fakerbot help search` command successfully' do
    output = `fakerbot help search`
    expected_output = <<~OUT
      Usage:
        fakerbot search [Faker]

      Options:
        -h, [--help], [--no-help]                  # Display usage information
        -m, [--show-methods], [--no-show-methods]  # Display Faker constants with methods
                                                   # Default: true
        -v, [--verbose], [--no-verbose]            # Include sample Faker output

      Search Faker method(s)
    OUT
    expect(output).to match(expected_output)
  end

  context 'when search query exists' do
    it 'returns results' do
      output = `fakerbot search name`
      expect(output).to match(/Faker::/)
      expect(output).to match(/└──/)
    end
  end

  context 'when search query does not exist' do
    it 'returns a not found message' do
      output = `fakerbot search foobar`
      expect(output).to match(/Sorry, we couldn't find a match/)
    end
  end
end
