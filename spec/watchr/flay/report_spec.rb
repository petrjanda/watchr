require 'spec_helper'
require 'watchr/flay/report'

describe Watchr::FlayMetric::Report do
  let(:report) { 
    Watchr::FlayMetric::Report.new('spec/fixtures')
  }

  describe '#total_score' do
    subject { report.total_score }

    it { should == 20 }
  end
end
