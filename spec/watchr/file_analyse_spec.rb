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

  describe '#loc' do
    let(:stats_report) do
      stub('stats_report', :loc => 10)
    end

    subject { file_analyse.loc }

    before do
      Watchr::Stats::Report.expects(:new).with(path).returns(stats_report)
    end

    it 'should return loc from stats report' do
      should == stats_report.loc
    end

    it 'should cache report' do
      file_analyse.loc

      Watchr::Stats::Report.expects(:new).never

      file_analyse.loc
    end
  end

  describe '#code_loc' do
    let(:stats_report) do
      stub('stats_report', :loc => 10, :code_loc => 20)
    end

    subject { file_analyse.code_loc }

    before do
      Watchr::Stats::Report.expects(:new).with(path).returns(stats_report)
    end

    it 'should return code_loc from stats report' do
      should == stats_report.code_loc
    end

    it 'should cache report' do
      file_analyse.loc.should == 10

      Watchr::Stats::Report.expects(:new).never

      file_analyse.code_loc.should == 20
    end
  end
end
