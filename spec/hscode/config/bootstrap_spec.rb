require 'spec_helper'
describe Bootstrap::Config do
  describe '#get' do
    let(:test_file_path) { File.expand_path('../../', __FILE__) }

    before do
      File.open("#{test_file_path}/config/env.yaml", 'w+') do |f|
        f.write 'password: theWestWorldMachin2@#$'
      end
    end

    after do
      File.delete("#{test_file_path}/config/env.yaml")
    end

    it 'gets all environment variables' do
      stub_const('APP_ROOT', test_file_path)
      expect(Bootstrap::Config.get.keys).to include 'password'
    end
  end
end
