require 'spec_helper'

module MockFaker
  class Foo
    def self.bar
      'bar'
    end
  end
end

RSpec.describe FakerBot::Renderer do
  describe '#call' do
    # FIXME: work out how to capture less
    xcontext 'when paginable interface' do
      before do
        expect_any_instance_of(described_class).to receive(:paginable?).and_return(true)
      end

      it 'renders paginated content' do
        hash = { MockFaker::Foo => [:bar] }
        options = {}
        output = StringIO.new

        renderer = described_class.new(hash, options, output)
        renderer.call

        expect(renderer.pager.page_height).to be_positive
        expect(output.string).to be_empty
      end
    end

    context 'when non-paginable interface' do
      before do
        expect_any_instance_of(described_class).to receive(:paginable?).and_return(false)
      end

      it 'renders the full content' do
        hash = { MockFaker::Foo => [:bar] }
        options = {}
        output = StringIO.new

        renderer = described_class.new(hash, options, output)
        renderer.call

        expect(output.string).to eq("MockFaker::Foo\n└── bar\n")
      end
    end
  end

  describe '#render' do
    context 'when the verbose option is enabled' do
      it 'renders methods with data' do
        hash = { MockFaker::Foo => [:bar] }
        options = { 'verbose' => true }
        output = StringIO.new

        renderer = described_class.new(hash, options, output)
        result = renderer.render

        expect(result).to eq("MockFaker::Foo\n└── bar=> bar\n")
        expect(output.string).to be_empty
      end
    end

    context 'when the verbose option is disabled' do
      it 'renders methods only' do
        hash = { MockFaker::Foo => [:bar] }
        options = { 'verbose' => false }
        output = StringIO.new

        renderer = described_class.new(hash, options, output)
        result = renderer.render

        expect(result).to eq("MockFaker::Foo\n└── bar\n")
        expect(output.string).to be_empty
      end
    end
  end

  describe '#tree' do
    it 'returns the tree object' do
      hash = { MockFaker::Foo => [:bar] }
      options = {}
      output = StringIO.new

      renderer = described_class.new(hash, options, output)
      result = renderer.tree

      expect(result.nodes.size).to be_positive
      expect(result).to be_a(TTY::Tree)
      expect(output.string).to be_empty
    end

    it 'memoizes the tree object' do
      hash = { MockFaker::Foo => [:bar] }
      options = {}
      output = StringIO.new

      renderer = described_class.new(hash, options, output)
      first_result = renderer.tree
      second_result = renderer.tree

      expect(first_result).to be(second_result)
    end
  end

  describe '#gt_screen_height?' do
    context 'when tree size is greater than the screen size' do
      before do
        expect(TTY::Screen).to receive(:height).and_return(1)
      end

      it 'returns true' do
        hash = { MockFaker::Foo => [:bar] }
        options = {}
        output = StringIO.new

        renderer = described_class.new(hash, options, output)
        result = renderer.gt_screen_height?

        expect(result).to be(true)
      end
    end

    context 'when the tree size is less than the screen size' do
      it 'returns false' do
        hash = { MockFaker::Foo => [:bar] }
        options = {}
        output = StringIO.new

        renderer = described_class.new(hash, options, output)
        result = renderer.gt_screen_height?

        expect(result).to be(false)
      end
    end
  end

  describe '#paginable?' do
    context 'when interactive terminal' do
      before do
        expect(TTY::Screen).to receive(:height).and_return(1)
        allow_any_instance_of(StringIO).to receive(:tty?).and_return(true)
      end

      it 'returns true' do
        hash = { MockFaker::Foo => [:bar] }
        options = {}
        output = StringIO.new

        renderer = described_class.new(hash, options, output)
        result = renderer.paginable?

        expect(result).to be(true)
      end
    end

    context 'when non-interactive terminal' do
      it 'returns false' do
        hash = { MockFaker::Foo => [:bar] }
        options = {}
        output = StringIO.new

        renderer = described_class.new(hash, options, output)
        result = renderer.paginable?

        expect(result).to be(false)
      end
    end
  end
end
