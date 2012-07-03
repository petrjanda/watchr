require 'spec_helper'
require 'watchr/flog_metric/report'

describe Watchr::FlogMetric::Report do
  let(:flog_report) { 
    Watchr::FlogMetric::Report.new([
      'spec/fixtures/class.rb', 
      'spec/fixtures/module.rb'
    ])
  }

  describe '#total_score' do
    subject { flog_report.total_score }

    it { should == 6 }
  end

  describe '#classes' do
    describe 'Foo' do
      subject { flog_report.classes.first }

      its(:name) { should == 'Baz::Foo' }
      its(:total_score) { should == 4.5 }
      its(:total_methods_score) { should == 3.4 }
      its(:file) { should == 'spec/fixtures/class.rb' }


      describe '.methods' do
        describe '.last' do
          subject { flog_report.classes.first.methods.last }

          its(:name) { should == 'bar' }
          its(:full_name) { should == 'Baz::Foo#bar' }
          its(:total_score) { should == 1.7 }
          its(:file) { should == 'spec/fixtures/class.rb' }
          its(:line) { should == 5 }
          its(:clazz) { should == flog_report.classes.first }
        end

        describe '.first' do
          subject { flog_report.classes.first.methods.first }

          its(:name) { should == 'bar' }
          its(:full_name) { should == 'Baz::Foo::bar' }
          its(:total_score) { should == 1.7 }
          its(:file) { should == 'spec/fixtures/class.rb' }
          its(:line) { should == 13 }
          its(:clazz) { should == flog_report.classes.first }
        end
      end
    end
  end

  describe '#by_file' do
    subject { flog_report.classes_by_file('fixture') }

    let(:klass) { stub('klass', :file => 'fixture') }

    let(:classes) { [klass] }

    before { flog_report.stubs(:classes).returns(classes) }

    it { should include(klass) }
  end
end

