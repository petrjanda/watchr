require 'spec_helper'
require 'watchr/flog_report'

describe Watchr::FlogReport do
  let(:flog_report) { Watchr::FlogReport.new('spec/fixtures/class.rb') }

  describe '#total_score' do
    subject { flog_report.total_score }

    it { should == 1.6 }
  end

  describe '#classes' do
    describe 'Foo' do
      subject { flog_report.classes.first }

      its(:name) { should == 'Foo' }
      its(:total_score) { should == 1.6 }
      its(:total_methods_score) { should == 1.6 }
      its(:file) { should == 'spec/fixtures/class.rb' }


      describe '.methods' do
        subject { flog_report.classes.first.methods.first }

        its(:name) { should == 'bar' }
        its(:full_name) { should == 'Foo#bar' }
        its(:total_score) { should == 1.6 }
        its(:file) { should == 'spec/fixtures/class.rb' }
        its(:line) { should == 2 }
        its(:clazz) { should == flog_report.classes.first }
      end
    end
  end
end

