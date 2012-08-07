require 'spec_helper'
require 'watchr/smell_builder'

describe Watchr::SmellBuilder do
  context 'invalid smell type' do
    subject { Watchr::SmellBuilder.new(:foo, '', '') }
    
    it { lambda { subject }.should raise_error "Invalid smell type 'foo'" }
  end
end