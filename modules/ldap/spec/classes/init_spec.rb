require 'spec_helper'
describe 'ldap' do

  context 'with defaults for all parameters' do
    it { should contain_class('ldap') }
  end
end
