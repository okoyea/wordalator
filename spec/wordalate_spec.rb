require 'spec_helper'
require 'wordalator'

describe Wordalator do
  describe 'parse' do
    it 'should return the correct result when there is only one sentence' do
      expect(Wordalator.parse('What is 10 divided by 2?')).to eq 5
    end

    it 'should return the correct results when there are multiple operators in one sentence' do
      expect(Wordalator.parse('What is 4 plus 10 divided by 2?')).to eq 7
    end

    it 'should return the correct results when there are multiple sentences' do
      results = Wordalator.parse('What is 10 divided by 2? What is 4 plus 10 divided by 2? What is 4 to the 2nd power?')
      expect(results).to eq [5, 7, 16]
    end

    it 'should return the correct results when the solution is a decimal number' do
      expect(Wordalator.parse('What is 4 plus 10 plus 5 divided by 2?')).to eq 9.5
    end
  end
end