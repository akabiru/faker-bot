# frozen_string_literal: true

RSpec.describe '`fakerbot list` command', type: :cli do
  it 'executes `fakerbot help list` command successfully' do
    output = `fakerbot help list`
    expected_output = <<~OUT
      Usage:
        fakerbot list

      Options:
        -h, [--help], [--no-help]        # Display usage information
        -v, [--verbose], [--no-verbose]  # Display Faker constants with methods

      List all Faker constants
      OUT

    expect(output).to eq(expected_output)
  end

  it 'executes `fakerbot list` command successfully' do
    output = `fakerbot list`
    expect(output).to match(/Faker::/)
  end

  it 'executes `fakerbot list -v` command successfully' do
    output = `fakerbot list -v`
    expect(output).to match(/Faker::/)
  end
end
