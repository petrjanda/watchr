require 'spec_helper'
require 'watchr/paths'

describe Watchr::Paths do
  describe '.files_by_dirs' do
    context 'single folder' do
      subject { Watchr::Paths.files_by_dirs(['rb'], 'spec/fixtures/') }

      it { should include('spec/fixtures/class.rb') }
    end

    context 'multiple folders' do
      subject { Watchr::Paths.files_by_dirs(['rb'], 'spec/fixtures/', 'lib/') }

      it { should include('lib/watchr.rb') }
      it { should include('spec/fixtures/class.rb') }
    end
  end
end
