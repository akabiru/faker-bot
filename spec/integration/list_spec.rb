# frozen_string_literal: true

RSpec.describe '`faker list` command', type: :cli do
  it 'executes `faker help list` command successfully' do
    output = `faker help list`
    expected_output = <<~OUT
      Usage:
        faker list

      Options:
        -h, [--help], [--no-help]                  # Display usage information
        -m, [--show-methods], [--no-show-methods]  # Display Faker constants with methods
                                                   # Default: true
        -v, [--verbose], [--no-verbose]            # Include sample Faker output

      List all Faker constants
    OUT

    expect(output).to match(expected_output)
  end

  it 'executes `faker list` command successfully' do
    output = `faker list`
    expect(output).to match(/Faker::/)
  end

  it 'executes `faker list -v` command successfully' do
    output = `faker list -v`
    expect(output).to match(/Faker::/)
  end
end
