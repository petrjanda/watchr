require 'spec_helper'
require 'watchr/analysers/reek'

describe Watchr::Analysers::Reek do
  let(:analyse) { 
    analyse = stub('analyse', :add_smell => true)
    analyse.extend Watchr::Analysers::Reek

    analyse
  }

  describe '#analyse_reek' do
    subject { analyse.analyse_reek(report) }

    let(:reek_smell) { stub('smell',
      :smell => {
        'subclass' => 'BooleanParameter',
        'message' => 'message'
      },

      :location => {
        'context' => 'context',
        'lines' => [12],
        'source' => 'source.rb' 
      })
    }

    let(:reek_smells) { [reek_smell] }

    let(:report) { stub('report', :smells => reek_smells) }

    let(:smell) { stub('smell', :add_location => true) }

    it 'should add smell for each reek report smell' do
      Watchr::Smell.expects(:new).with(:boolean_parameter, 'context', 'message').returns(smell)

      analyse.expects(:add_smell).returns(smell)

      subject
    end
  end
end
