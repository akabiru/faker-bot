# frozen_string_literal: true

RSpec.describe '`faker/cli list` command', type: :cli do
  it 'executes `faker/cli help list` command successfully' do
    output = `faker/cli help list`
    expected_output = <<~OUT
      Usage:
        faker/cli list

      Options:
        -h, [--help], [--no-help]                  # Display usage information
        -m, [--show-methods], [--no-show-methods]  # Display Faker constants with methods
                                                   # Default: true
        -v, [--verbose], [--no-verbose]            # Include sample Faker output

      List all Faker constants
    OUT

    expect(output).to match(expected_output)
  end

  it 'executes `faker/cli list` command successfully' do
    output = `faker/cli list`
    expect(output).to match(/Faker::/)
  end

  it 'executes `faker/cli list -v` command successfully' do
    output = `faker/cli list -v`
    expect(output).to match(/Faker::/)
  end
end
