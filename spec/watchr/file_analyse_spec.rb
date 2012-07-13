require 'spec_helper'
require 'watchr/file_analyse'

describe Watchr::FileAnalyse do

  it { Watchr::FileAnalyse.ancestors.should include(Watchr::Analysers::Flog) }

  let(:path) { 'spec/fixtures/class.rb' }

  let(:file_analyse) { Watchr::FileAnalyse.new(path) }

  describe '#path' do
    subject { file_analyse.path }

    it { should == path }
  end

  describe '#smelly?' do
    subject { file_analyse.smelly? }

    context 'with no smells' do
      before { file_analyse.stubs(:smells).returns([]) }

      it { should be_false }
    end

    context 'with smells' do
      let(:smell) { stub('smell') }

      before { file_analyse.stubs(:smells).returns([smell]) }

      it { should be_true }
    end
  end
end
