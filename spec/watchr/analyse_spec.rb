require 'spec_helper'
require 'watchr/analyse'

describe Watchr::Analyse do
  let(:analyse) { Watchr::Analyse.new('spec/fixtures/') }

  describe '#files' do
    subject { analyse.files }

    its(:count) { should == 2 }

    describe 'first' do
      subject { analyse.files.first }
    
      its(:class) { should == Watchr::FileAnalyse }
      its(:path) { should == 'spec/fixtures/class.rb' }
    end
  end

  describe '#path' do
    subject { analyse.path }

    it { should == 'spec/fixtures/' }
  end
end
