require 'spec_helper'
describe 'openwa' do

  context 'with defaults for all parameters' do
    it { should contain_class('openwa') }
  end
end
