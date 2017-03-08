require 'spec_helper'

describe Hscode::InputParser do
  describe '#parse' do
    let(:new_input_parser) { described_class.new }

    it 'initializes with an empty open struct' do
      expect(new_input_parser.options).to be_an_instance_of(OpenStruct)
    end

    context 'when option is `-c 500``' do
      let(:options) { new_input_parser.parse(['-c', '500', '-v']) }

      it 'sets parsed options in @options' do
        expect(options).to be_an_instance_of(OpenStruct)
        expect(options.verbose).to be true
        expect(options.status_code).to eq(500)
      end
    end

    context 'when option is `-l 5xx`' do
      it 'should be a struct with status type 5xx' do
        allow_any_instance_of(Object).to receive(:exit).and_return(0)
        options = new_input_parser.parse(['-l', '5xx'])
        expect(options).to be_an_instance_of(OpenStruct)
        expect(options.verbose).to be nil
        expect(options.status_type).to eq('5xx')
      end

      it 'prints http codes under 5xx Server Error' do
        stdout, stderr, status = Open3.capture3('./bin/hscode -l 5xx')
        expect(stdout).to include '5xx   Server Error'
        expect(stderr.empty?).to be true
        expect(status.success?).to be true
      end
    end

    context 'when option is `-l 5xc`' do
      it 'should be a struct with incorrect status type 5xc' do
        allow_any_instance_of(Object).to receive(:abort).and_return(1)
        allow_any_instance_of(Object).to receive(:exit).and_return(0)

        options = new_input_parser.parse(['-l', '5xc'])
        expect(options).to be_an_instance_of(OpenStruct)
        expect(options.verbose).to be nil
        expect(options.status_type).to eq('5xc')
      end

      it 'prints error message and exit with 1' do
        stdout, stderr, status = Open3.capture3('./bin/hscode -l 5xc')
        expect(stdout.empty?).to be true
        expect(stderr).to include '5xc is not a valid code type'
        expect(status.success?).to be false
      end
    end

    context 'when option is `-l`' do
      it 'should be a struct with no status type' do
        allow_any_instance_of(Object).to receive(:abort).and_return(1)
        allow_any_instance_of(Object).to receive(:exit).and_return(0)

        options = new_input_parser.parse(['-l'])
        expect(options).to be_an_instance_of(OpenStruct)
        expect(options.status_type).to be nil
      end

      it 'prints all http codes' do
        stdout, stderr, status = Open3.capture3('./bin/hscode -l')
        expect(stdout.length).to be > 300
        expect(stderr.empty?).to be true
        expect(status.success?).to be true
      end
    end

    context 'when option is `--help`' do
      it 'should be a struct' do
        allow_any_instance_of(Object).to receive(:abort).and_return(1)
        allow_any_instance_of(Object).to receive(:exit).and_return(0)

        options = new_input_parser.parse(['--help'])
        expect(options).to be_an_instance_of(OpenStruct)
      end

      it 'prints help message' do
        stdout, stderr, status = Open3.capture3('./bin/hscode --help')
        expect(stdout).to include 'Examples:'
        expect(stderr.empty?).to be true
        expect(status.success?).to be true
      end
    end

    context 'when option is `--version`' do
      it 'should be a struct' do
        allow_any_instance_of(Object).to receive(:abort).and_return(1)
        allow_any_instance_of(Object).to receive(:exit).and_return(0)

        options = new_input_parser.parse(['--version'])
        expect(options).to be_an_instance_of(OpenStruct)
      end

      it 'displays the help message' do
        stdout, stderr, status = Open3.capture3('./bin/hscode --version')
        expect(stdout).to match(/\d.\d.\d/)
        expect(stderr.empty?).to be true
        expect(status.success?).to be true
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
