require 'spec_helper'
require 'watchr/smell'

describe Watchr::Smell do

  let(:type) { 'foo' }

  let(:location) { 'location' }

  let(:locations) { location }

  let(:description) { 'description' }

  let(:context) { 'context' }

  let(:smell) { Watchr::Smell.new(type, context, description, locations) }

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

  describe '#description' do
    its(:description) { should == description }
  end

  describe '#context' do
    its(:context) { should == context }
  end
end
