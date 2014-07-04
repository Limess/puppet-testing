require 'spec_helper'
describe 'tw_go' do

  context 'with defaults for all parameters' do
    it { should contain_class('tw_go') }
  end
end
