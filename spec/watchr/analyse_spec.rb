require 'spec_helper'
require 'watchr/analyse'

describe Watchr::Analyse do
  let(:analyse) { Watchr::Analyse.new('spec/fixtures/') }

  describe '#files' do
    subject { analyse.files }

    its(:count) { should == 2 }
    its(:first) { subject.class.should == Watchr::FileAnalyse }
  end

  describe '#path' do
    subject { analyse.path }

    it { should == 'spec/fixtures/' }
  end
end
