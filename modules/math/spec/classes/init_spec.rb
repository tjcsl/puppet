require 'spec_helper'
describe 'math' do

  context 'with defaults for all parameters' do
    it { should contain_class('math') }
  end
end
