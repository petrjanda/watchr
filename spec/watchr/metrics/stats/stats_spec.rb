require 'spec_helper'
require 'watchr/metrics/stats/report'

describe Watchr::Stats::Report do
  let(:stats) do
    Watchr::Stats::Report.new(
      'spec/fixtures/class.rb'
    )
  end

  describe '#loc' do  
    subject { stats.loc }

    it { should == 24 }
  end

  describe '#code_loc' do
    subject { stats.code_loc }

    it { should == 19 }
  end
end