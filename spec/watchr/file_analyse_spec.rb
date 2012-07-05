require 'spec_helper'
require 'watchr/file_analyse'

describe Watchr::FileAnalyse do
  let(:path) { 'spec/fixtures/class.rb' }

  let(:file_analyse) { Watchr::FileAnalyse.new(path) }

  describe '#path' do
    subject { file_analyse.path }

    it { should == path }
  end
end
