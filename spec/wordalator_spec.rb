require 'spec_helper'

describe Wordalator do
  subject { Object.new.extend Wordalator }

  describe 'wordalate' do
    it 'should return the results when there in only one sentence' do
      results = subject.wordalate('What is 10 divided by 2?')
      expect(results).to eq 5
    end

    it 'should return the results when there are multiple operators' do
      results = subject.wordalate('What is 4 plus 10 divided by 2?')
      expect(results).to eq 7
    end

    it 'should return the results when there are multiple sentences' do
      results = subject.wordalate('What is 10 divided by 2? What is 4 plus 10 divided by 2? What is 4 to the 2nd power?')
      expect(results).to eq [5, 7, 16]
    end

    it 'should return the results when the solution is a decimal number' do
      results = subject.wordalate('What is 4 plus 10 plus 5 divided by 2?')
      expect(results).to eq 9.5
    end
  end

  describe 'separate nums from ops' do
    it 'should return an array of numbers' do
      results = subject.separate_nums_from_ops(['2', '3', 'plus'])
      expect(results[0]).to eq ['2','3']
    end

    it 'should return an array of numbers' do
      results = subject.separate_nums_from_ops(['2', '3', 'plus'])
      expect(results[1]).to eq ['plus']
    end
  end

  describe 'do_the_math'  do
    it 'should add numbers when there is the word "plus"' do
      expect(subject.do_the_math(['4', '2'],['power'])).to eq 16
    end

    it 'should subtract numbers when there is the word "minus"' do
        expect(subject.do_the_math(['4', '2'], ['minus'])).to eq 2
    end

    it 'should subtract numbers when there is the word "times"'  do
        expect(subject.do_the_math(['5', '3'],['times'])).to eq 15
    end

    it 'should divide numbers when there is the phrase "divided by"' do
        expect(subject.do_the_math(['6','3'], ['divided'])).to eq 2
    end

    it 'should raise a number to a power when there is the word "power"' do
        expect(subject.do_the_math(['4','2'], ['power'])).to eq 16
    end

    it 'should return an answer for multiple operations' do
        expect(subject.do_the_math(['4', '6', '2'], ['plus', 'divided'])).to eq 5
    end
  end

  describe 'exclude_words' do
    it 'should remove any unnecessary words from the sentence' do
      result = subject.exclude_words('What is 4 to the 2nd power?')
      expect(result).to eq ['4', '2nd', 'power?']
    end
  end

  describe 'strip_suffixes' do
    it 'should strip any suffixes' do
      result = subject.strip_suffixes(['4', '2nd', 'power?'])
      expect(result).to eq ['4', '2', 'power']
    end
  end

  describe 'separate nums from ops' do
    it 'should separate the numbers from the operators' do
      nums,ops = subject.separate_nums_from_ops(['4', '2', 'power'])
      expect(nums).to eq ['4', '2']
      expect(ops).to eq ['power']
    end
  end
end