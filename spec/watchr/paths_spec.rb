require 'spec_helper'
require 'watchr/paths'

describe Watchr::Paths do
  describe '.files_by_dirs' do

    subject { Watchr::Paths.files_by_dirs('spec/fixtures/') }

    it { should include('spec/fixtures/class.rb') }
  end
end
