require 'spec_helper'
require 'watchr/smell'

describe Watchr::Smell do

  let(:type) { 'foo' }

  let(:location) { 'location' }

  let(:description) { 'description' }

  let(:context) { 'context' }

  let(:details) { stub('details') }

  let(:smell) { Watchr::Smell.new(type, context, description) }

  subject { smell }

  describe '#type' do
    its(:type) { should == type }
  end

  describe '#locations' do
    subject { smell.locations }

    before { smell.add_location(location) }

    context 'one location' do
      it { should == [location] }
    end

    context 'multiple locations' do
      before { smell.add_location(location) }

      it { should == [location, location] }
    end
  end

  its(:description) { should == description }

  describe '#details' do
    context 'without any' do
      its(:details) { should == nil }
    end

    context 'with given' do
      before { smell.details = details }

      its(:details) { should == details }
    end
  end

  its(:context) { should == context }
end
