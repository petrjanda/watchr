require 'spec_helper'
require 'watchr/analysers/flog'

describe Watchr::Analysers::Flog do
  let(:analyse) { 
    analyse = stub('analyse', :add_smell => true)
    analyse.extend Watchr::Analysers::Flog

    analyse
  }

  let(:method) { stub('method',
    :name => 'method',
    :location => stub('location'),
    :total_score => 10) 
  }

  let(:complex_method) { stub('method',
    :name => 'complex_method',
    :location => stub('location'),
    :total_score => 30)
  }

  let(:very_complex_method) { stub('method',
    :name => 'very_complex_method',
    :location => stub('location'),
    :total_score => 100)
  }

  let(:clazz) { stub('class',
    :name => 'Class',
    :location => stub('location'),
    :total_score => 100,
    :methods => [method, complex_method, very_complex_method])
  }
  
  let(:classes) { [clazz] }

  let(:report) { stub('report', :classes => classes) }

  subject { analyse.analyse_flog(report) }

  describe '#analyse_flog' do
    let(:smell) { stub('smell') }

    before { Watchr::Smell.stubs(:new).returns(smell) }

    it 'should add smell for complex method' do
      Watchr::Smell.expects(:new).with(
        Watchr::Smell::COMPLEX_METHOD,
        complex_method.name,
        '',
        complex_method.location,
        { :score => complex_method.total_score }
      )

      analyse.expects(:add_smell).returns(smell)

      subject
    end

    it 'should add smell for very complex method' do
      Watchr::Smell.expects(:new).with(
        Watchr::Smell::VERY_COMPLEX_METHOD,
        very_complex_method.name,
        '',
        very_complex_method.location,
        { :score => very_complex_method.total_score }
      )

      analyse.expects(:add_smell).returns(smell)

      subject
    end

    it 'should add smell for very complex object' do
      Watchr::Smell.expects(:new).with(
        Watchr::Smell::VERY_COMPLEX_OBJECT,
        clazz.name,
        '',
        clazz.location,
        { :score => clazz.total_score }
      )

      analyse.expects(:add_smell).returns(smell)

      subject
    end

  end
end
