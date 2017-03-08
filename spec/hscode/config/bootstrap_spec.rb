require 'spec_helper'
describe Bootstrap::Config do
  describe '#get' do
    let(:root) { APP_ROOT }

    it 'gets all environment variables' do
      File.open("#{root}/config/env.yaml", 'w+') do |f|
        f.write 'password: W3jjjj.bnr'
      end
      expect(Bootstrap::Config.get.keys).to include 'password'
      File.delete("#{root}/config/env.yaml")
    end
  end
end
