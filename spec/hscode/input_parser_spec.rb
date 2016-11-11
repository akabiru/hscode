require 'spec_helper'

describe Hscode::InputParser do
  describe '#parse' do
    let(:new_input_parser) { described_class.new }

    it 'initializes with an empty open struct' do
      expect(new_input_parser.options).to be_an_instance_of(OpenStruct)
    end

    context 'Valid requests' do
      let(:options) { new_input_parser.parse(['-c', '500', '-v']) }

      it 'sets parsed options in @options' do
        expect(options).to be_an_instance_of(OpenStruct)
        expect(options.verbose).to be true
        expect(options.status_code).to eq(500)
      end
    end
  end
end
