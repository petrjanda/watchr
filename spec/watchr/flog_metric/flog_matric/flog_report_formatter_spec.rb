require 'spec_helper'
require 'watchr/flog_metric/class'
require 'watchr/flog_metric/formatter'

describe Watchr::FlogReportFormatter do

  let(:flog_class_report) { Watchr::FlogReportClass.new('Foo', 1.4) }
  
  let(:flog_method_report) { Watchr::FlogReportMethod.new(flog_class_report, 'Foo#bar', 1.2, 'foo.rb:2') }

  let(:flog_report) { stub('flog_report',
      :total_score => 143.23,
      :classes => [flog_class_report]
    )
  }

  before { flog_class_report.add_method(flog_method_report) }

  describe '.generate' do
    subject { Watchr::FlogReportFormatter.generate(flog_report) }

    it 'created the aggregated data output' do
      should == {
        :total_score=>143.23, 
        :classes=>[
          {
            :name=>"Foo", 
            :total_score=>1.4, 
            :methods_total_score=>1.2, 
            :file=>"foo.rb", 

            :methods=>[
              {
                :name=>"bar", 
                :total_score=>1.2, 
                :file=>"foo.rb", 
                :line=>2
              }
            ]
          }
        ]
      }
    end
  end
end
