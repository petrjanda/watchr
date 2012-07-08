require 'spec_helper'
require 'watchr/rating'

describe Watchr::Rating do

  let(:complexity_smell) { 
    stub('smell', 
      :type => Watchr::SmellTypes::COMPLEX_METHOD,
      :options => {:score => 29.3})
  }

  let(:duplication_smell) { 
    stub('smell', 
      :type => Watchr::SmellTypes::IDENTICAL_CODE,
      :options => {:mass => 72})
  }

  let(:smells) { [complexity_smell, duplication_smell] }

  let(:analyse) {
    analyse = stub('analyse', :smells => smells)
    analyse.extend Watchr::Rating

    analyse
  }

  describe '#rating' do
    subject { analyse.rating }

    it { should == 'F' }
  end
end
