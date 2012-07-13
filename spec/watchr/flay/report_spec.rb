require 'spec_helper'
require 'watchr/metrics/flay/report'

describe Watchr::FlayMetric::Report do
  let(:report) { 
    Watchr::FlayMetric::Report.new('spec/fixtures/')
  }

  describe '#total_score' do
    subject { report.total_score }

    it { should == 52 }
  end

  describe '#duplications' do
    describe '.first' do
      subject { report.duplications.first }

      describe 'locations' do
        subject { report.duplications.first.locations }

        its(:first) { subject.file.should == 'spec/fixtures/class.rb' }
        its(:first) { subject.line.should == 5 }

        its(:last) { subject.file.should == 'spec/fixtures/module.rb' }
        its(:last) { subject.line.should == 2 }
      end
    end
  end
end
