RSpec.describe "`fakerbot list` command", type: :cli do
  it "executes `fakerbot help list` command successfully" do
    output = `fakerbot help list`
    expected_output = <<-OUT
Usage:
  fakerbot list

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
