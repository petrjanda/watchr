require 'spec_helper'
require 'lib/watchr/flog_report_class'
require 'lib/watchr/flog_json_report'

describe Watchr::FlogJsonReport do

  let(:flog_class_report) { Watchr::FlogReportClass.new('Foo', 1.4) }

  let(:flog_report) { stub('flog_report',
      :total_score => 143.23,
      :classes => [flog_class_report]
    )
  }

  subject { Watchr::FlogJsonReport.new(flog_report) }

  it { should == """
{}
""" }
end
