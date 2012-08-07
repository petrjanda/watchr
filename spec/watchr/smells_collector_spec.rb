require 'spec_helper'
require 'watchr/smells_collector'

describe Watchr::SmellsCollector do
  let(:collector) { Watchr::SmellsCollector.new }

  describe '#all' do

    subject { collector.all }

    context 'with no smells' do
      it { should be_empty }
    end

    context 'with smells' do
      let(:smell) { stub('smell') }

      before { collector.add(smell) }

      it { should_not be_empty }
      its(:first) { should == smell }
    end
  end

  describe '#empty?' do
    subject { collector.empty? }

    context 'with no smells' do
      it { should be_true }
    end

    context 'with smells' do
      let(:smell) { stub('smell') }

      before { collector.add(smell) }

      it { should be_false }
    end
  end
end
