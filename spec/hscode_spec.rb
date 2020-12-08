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
          expect do
            expect(verbose_cmd).to be_an_instance_of(Array)
              .to match_array(Hscode::HTTP_STATUS_CODES[200][:description])
          end.to terminate.with_code(0)
        end
      end

      context 'when options is search' do
        let(:search_cmd) { described_class.call(['-s', 'ok']) }
        let(:search_verbose_cmd) { described_class.call(['-s', 'ok', '-v']) }
        let(:bad_search_cmd) { described_class.call(['-s', 'notfound', '-v']) }
        let(:error_msg) { 'notfound is not a valid HTTP status.' }

        it 'prints search result' do
          expect do
            expect(search_cmd).to be_an_instance_of(Array)
          end.to terminate.with_code(0)
        end

        it 'prints full status code documentation with ' do
          expect do
            expect(search_verbose_cmd).to be_an_instance_of(Array)
          end.to terminate.with_code(0)
        end

        it 'prints an error message' do
          expect do
            expect(bad_search_cmd).to match error_msg
          end.to terminate.with_code(1)
        end
      end

      context 'when options is non verbose' do
        let(:non_verbose_cmd) { described_class.call(['-c', '422']) }

        it 'prints code title' do
          expect do
            expect(non_verbose_cmd).to be_nil
          end.to terminate.with_code(0)
        end
      end

      context 'when status code is invalid' do
        let(:invalid_code) { described_class.call(['-c', '800']) }
        let(:error_msg) { "800 is not a valid code. See 'hscode --help'." }

        it 'prints an error message' do
          expect do
            expect(invalid_code).to be_eql error_msg
          end.to terminate.with_code(1)
        end
      end
    end
  end
end
