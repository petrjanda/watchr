require 'spec_helper'
require 'watchr/rating'

describe Watchr::Rating do

  let(:complexity_smell) { 
    stub('smell', 
      :type => :complex_method,
      :details => {:complexity => 29.3}
    )
  }

  let(:other_smell) { 
    stub('smell', 
      :type => 'other'
    )
  }

  let(:duplication_smell) { 
    stub('smell', 
      :type => :identical_code,
      :details => {:mass => 72})
  }

  let(:smells) { [complexity_smell, other_smell, duplication_smell] }

  let(:analyse) {
    analyse = stub('analyse', :smells => smells)
    analyse.extend Watchr::Rating

    analyse
  }

  describe '#rating' do
    subject { analyse.rating }

    context 'C' do
      it { should == 'C' }
    end

    context 'A' do
      let(:smells) { [] }
      it { should == 'A' }
    end
  end
end
