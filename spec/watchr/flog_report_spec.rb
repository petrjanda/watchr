require 'spec_helper'
require 'watchr/flog_report'

describe Watchr::FlogReport do
  let(:flog_report) { Watchr::FlogReport.new(['spec/fixtures/class.rb', 'spec/fixtures/module.rb']) }

  describe '#total_score' do
    subject { flog_report.total_score }

    it { should == 6 }
  end

  describe '#classes' do
    describe 'Foo' do
      subject { flog_report.classes.first }

      its(:name) { should == 'Foo' }
      its(:total_score) { should == 4.5 }
      its(:total_methods_score) { should == 3.4 }
      its(:file) { should == 'spec/fixtures/class.rb' }


      describe '.methods' do
        describe '.first' do
          subject { flog_report.classes.first.methods.first }

          its(:name) { should == 'bar' }
          its(:full_name) { should == 'Foo#bar' }
          its(:total_score) { should == 1.7 }
          its(:file) { should == 'spec/fixtures/class.rb' }
          its(:line) { should == 4 }
          its(:clazz) { should == flog_report.classes.first }
        end

        describe '.last' do
          subject { flog_report.classes.first.methods.last }

          its(:name) { should == 'bar' }
          its(:full_name) { should == 'Foo::bar' }
          its(:total_score) { should == 1.7 }
          its(:file) { should == 'spec/fixtures/class.rb' }
          its(:line) { should == 12 }
          its(:clazz) { should == flog_report.classes.first }
        end
      end
    end
  end
end

