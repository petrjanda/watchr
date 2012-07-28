require 'spec_helper'
require 'watchr/metrics/flog/report'

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

      describe '#location' do
        subject { flog_report.classes.first.location }
        
        its(:file) { should == 'spec/fixtures/class.rb' }
      end


      describe '.methods' do
        describe '.last' do
          subject { flog_report.classes.first.methods.last }

          its(:method_name) { should == 'bar' }
          its(:name) { should == 'Baz::Foo#bar' }
          its(:total_score) { should == 1.7 }
          its(:clazz) { should == flog_report.classes.first }

          describe '#location' do
            subject { flog_report.classes.first.methods.last.location }

            its(:file) { should == 'spec/fixtures/class.rb' }
            its(:line) { should == 5 }
          end
        end

        describe '.first' do
          subject { flog_report.classes.first.methods.first }

          its(:method_name) { should == 'bar' }
          its(:name) { should == 'Baz::Foo::bar' }
          its(:total_score) { should == 1.7 }
          its(:clazz) { should == flog_report.classes.first }

          describe '#location' do
            subject { flog_report.classes.first.methods.first.location }

            its(:file) { should == 'spec/fixtures/class.rb' }
            its(:line) { should == 13 }
          end

        end
      end
    end
  end

  describe '#by_file' do
    subject { flog_report.classes_by_file('fixture') }

    let(:classes) { [klass] }

    before { flog_report.stubs(:classes).returns(classes) }

    context 'with matching file' do
      let(:klass) { stub('klass', :file => 'fixture') }

      it { should include(klass) }
    end

    context 'without matching file' do
      let(:klass) { stub('klass', :file => 'blah') }

      it { should_not include(klass) }
    end
  end
end

