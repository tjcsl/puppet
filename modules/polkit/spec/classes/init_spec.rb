require 'spec_helper'
describe 'polkit' do

  context 'with defaults for all parameters' do
    it { should contain_class('polkit') }
  end
end
