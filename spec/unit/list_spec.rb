require 'fakerbot/commands/list'

RSpec.describe Fakerbot::Commands::List do
  it "executes `list` command successfully" do
    output = StringIO.new
    options = {}
    command = Fakerbot::Commands::List.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
