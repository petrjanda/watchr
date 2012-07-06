require 'spec_helper'
require 'watchr/smell'

describe Watchr::Smell do

  let(:type) { 'foo' }

  let(:location) { 'location' }

  let(:locations) { location }

  let(:description) { 'description' }

  let(:context) { 'context' }

  let(:options) { stub('options') }

  let(:smell) { Watchr::Smell.new(type, context, description, locations, options) }

  subject { smell }

  describe '#type' do
    its(:type) { should == type }
  end

  describe '#locations' do
    subject { smell.locations }

    context 'one location' do
      it { should == [location] }
    end

    context 'multiple locations' do
      let(:locations) { [location, location] }

      it { should == [location, location] }
    end
  end

  its(:description) { should == description }

  its(:options) { should == options }

  its(:context) { should == context }
end
