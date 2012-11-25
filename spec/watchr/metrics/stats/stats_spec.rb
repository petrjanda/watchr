require 'spec_helper'
require 'watchr/metrics/stats/report'

describe Watchr::Stats::Report do
  it 'should return LOC in given file' do
    stats = Watchr::Stats::Report.new(
      'spec/fixtures/class.rb'
    )

    stats.loc.should == 24
    stats.code_loc.should == 19
    stats.classes.should == 1
    stats.methods.should == 2
  end
end