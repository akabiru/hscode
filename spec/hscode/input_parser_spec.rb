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

    context 'valid list http code by type' do
      it 'returns all http codes belonging to type' do
        expect do
          options = new_input_parser.parse(['-l', '5xx'])
          expect(options).to be_an_instance_of(OpenStruct)
          expect(options.verbose).to be nil
          expect(options.status_type).to eq('5xx')
        end.to terminate.with_code(0)
      end
    end

    context 'list all http codes' do
      it 'returns all http codes' do
        expect do
          options = new_input_parser.parse(['-l'])
          expect(options).to be_an_instance_of(OpenStruct)
          expect(options.status_type).to be nil
        end.to terminate.with_code(0)
      end
    end

    context 'when option is --help' do
      it 'displays help message' do
        expect do
          options = new_input_parser.parse(['--help'])
          expect(options).to be_an_instance_of(OpenStruct)
          expect { options }.to output.to_stdout
        end.to terminate.with_code(0)
      end
    end

    context 'when option is --version' do
      it 'displays version' do
        expect do
          options = new_input_parser.parse(['--version'])
          expect(options).to be_an_instance_of(OpenStruct)
          expect { options }.to output.to_stdout
        end.to terminate.with_code(0)
      end
    end

    context 'Invalid requests' do
      let(:options) { new_input_parser.parse(['-f']) }

      it 'exit with status 1' do
        expect { options }.to terminate.with_code(1)
      end
    end
  end
end
