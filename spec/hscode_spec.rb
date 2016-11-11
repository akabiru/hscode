require 'spec_helper'

describe Hscode do
  it 'has a version number' do
    expect(Hscode::VERSION).not_to be nil
  end

  describe Hscode::CliController do
    it 'responds to .call' do
      expect(Hscode::CliController).to respond_to(:call)
    end

    describe '.call' do
      context 'when options is verbose' do
        let(:verbose_cmd) { described_class.call(['-c', '200', '-v']) }

        it 'prints full status code documentation' do
          expect(verbose_cmd).to be_an_instance_of(Array)
          expect(verbose_cmd)
            .to match_array(Hscode::HTTP_STATUS_CODES[200][:description])
        end
      end

      context 'when options is non verbose' do
        let(:non_verbose_cmd) { described_class.call(['-c', '422']) }

        it 'prints code title' do
          expect(non_verbose_cmd).to be_nil
        end
      end

      context 'when status code is invalid' do
        let(:invalid_code) { described_class.call(['-c', '800']) }
        let(:error_msg) { "800 is not a valid code. See 'hscode --help'." }

        it 'prints an error message' do
          expect(invalid_code).to be_eql error_msg
        end
      end
    end
  end
end
