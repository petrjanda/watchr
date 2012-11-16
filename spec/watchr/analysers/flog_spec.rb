require 'spec_helper'
require 'watchr/analysers/flog'

describe Watchr::Analysers::Flog do
  let(:analyse) { 
    analyse = stub('analyse', :add_smell => true)
    analyse.extend Watchr::Analysers::Flog

    analyse
  }

  let(:location) { stub('location', 
    :file => 'foo.rb', 
    :line => 20) 
  }

  let(:method) { stub('method',
    :name => 'method',
    :location => location,
    :total_score => 10) 
  }

  let(:complex_method) { stub('method',
    :name => 'complex_method',
    :location => location,
    :total_score => 30)
  }

  let(:very_complex_method) { stub('method',
    :name => 'very_complex_method',
    :location => location,
    :total_score => 100)
  }

  let(:clazz) { stub('class',
    :name => 'Class',
    :location => location,
    :total_score => 100,
    :methods => [method, complex_method, very_complex_method])
  }
  
  let(:classes) { [clazz] }

  let(:report) { stub('report', :classes => classes) }

  subject { analyse.analyse_flog(report) }

  describe '#analyse_flog' do
    let(:smell) { stub('smell') }

    let(:builder) { stub('builder', 
      :add_location => true, 
      :add_details => true, 
      :smell => smell) 
    }

    before { Watchr::SmellBuilder.stubs(:new).returns(builder) }

    it 'should add smell for complex method' do
      Watchr::SmellBuilder.expects(:new).with(
        :complex_method,
        complex_method.name,
        "complexity = #{complex_method.total_score}"
      ).returns(builder)

      analyse.expects(:add_smell).returns(smell)

      subject
    end

    it 'should add smell for very complex method' do
      Watchr::SmellBuilder.expects(:new).with(
        :very_complex_method,
        very_complex_method.name,
        "complexity = #{very_complex_method.total_score}"
      ).returns(builder)

      analyse.expects(:add_smell).returns(smell)

      subject
    end

    it 'should add smell for very complex object' do
      Watchr::SmellBuilder.expects(:new).with(
        :very_complex_object,
        clazz.name,
        "complexity = #{clazz.total_score}"
      ).returns(builder)

      analyse.expects(:add_smell).returns(smell)

      subject
    end
  end
end
