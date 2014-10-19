require 'spec_helper'
describe 'nsswitch' do

  context 'with defaults for all parameters' do
    it { should contain_class('nsswitch') }
  end
end
