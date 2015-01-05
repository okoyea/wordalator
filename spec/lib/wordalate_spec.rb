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
      results = Wordalator.parse('What is 10 divided by 2?', 'What is 4 plus 10 divided by 2?','What is 4 to the 2nd power?')
      expect(results).to eq [5, 7, 16]
    end

    it 'should return the correct results when the solution is a decimal number' do
      expect(Wordalator.parse('What is 4 plus 10 plus 5 divided by 2?')).to eq 9.5
    end

    it 'should raise an error when there are too few numbers' do
      lambda { Wordalator.parse('What is 6 times?') }.should raise_error(ArgumentError)
    end

    it 'should raise an error when there are too few operators' do
      lambda { Wordalator.parse('What is 20 plus 10 plus ?') }.should raise_error(ArgumentError)
    end
  end
end