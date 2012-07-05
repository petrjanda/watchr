require 'spec_helper'
require 'watchr/location'

describe Watchr::Location do
  let(:location) { Watchr::Location.new('foo.rb', 42) }

  subject { location }

  its(:file) { should == 'foo.rb' }
  its(:line) { should == 42 }

  describe '.from_path' do
    subject { Watchr::Location.from_path(path) }

    context 'with line' do
      let(:path) { 'foo.rb:21' }

      its(:file) { should == 'foo.rb' }
      its(:line) { should == 21 }
    end

    context 'without line' do
      let(:path) { 'foo.rb' }

      its(:file) { should == 'foo.rb' }
      its(:line) { should be_nil }
    end
  end
end
