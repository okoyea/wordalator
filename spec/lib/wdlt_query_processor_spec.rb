require 'spec_helper'
require 'wordalator/wdlt_query_processor'

#this must be kept in sync with the ones defined in constants module
COMPARATORS = %w(What what is by to the of raised)

describe WDLTQueryProcessor do
  let (:results) {WDLTQueryProcessor.new('What is 4 to the 2nd power?').process}

  describe 'process' do
    it 'should not contain any of the comparators' do
      expect(results).to_not include COMPARATORS
    end

    it 'should return an array of numbers at the 0 index without any suffixes' do
      expect(results[0]).to eq ['4','2']
    end

    it 'should return an array of operators at the 1 index' do
      expect(results[1]).to eq ['power']
    end
  end
end