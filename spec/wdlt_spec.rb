require 'spec_helper'
require 'wordalator/wdlt'

module Wordalator
  describe WDLT do
    let(:w) { WDLT.new('dummy query') }

    describe 'parse' do
      def do_parse(query)
        w = WDLT.new(query)
        w.parse
      end

      it 'should return the correct result when there is only one sentence' do
        expect(do_parse('What is 10 divided by 2?')).to eq 5
      end

      it 'should return the correct results when there are multiple operators in one sentence' do
        expect(do_parse('What is 4 plus 10 divided by 2?')).to eq 7
      end

      it 'should return the correct results when there are multiple sentences' do
        results = do_parse('What is 10 divided by 2? What is 4 plus 10 divided by 2? What is 4 to the 2nd power?')
        expect(results).to eq [5, 7, 16]
      end

      it 'should return the correct results when the solution is a decimal number' do
        expect(do_parse('What is 4 plus 10 plus 5 divided by 2?')).to eq 9.5
      end
    end

    describe 'separate nums from ops' do
      let (:results) { w.separate_nums_from_ops(['2', '3', 'plus']) }

      it 'should return an array of numbers' do
        expect(results[0]).to eq ['2','3']
      end

      it 'should return an array of numbers' do
        expect(results[1]).to eq ['plus']
      end
    end

    describe 'do_the_math'  do
      it 'should add numbers when the word "plus" is present' do
        expect(w.do_the_math(['4', '2'],['plus'])).to eq 6
      end

      it 'should subtract numbers when the word "minus" is present' do
          expect(w.do_the_math(['4', '2'], ['minus'])).to eq 2
      end

      it 'should subtract numbers when the word "times" is present'  do
          expect(w.do_the_math(['5', '3'],['times'])).to eq 15
      end

      it 'should divide numbers when the phrase "divided by" is present' do
          expect(w.do_the_math(['6','3'], ['divided'])).to eq 2
      end

      it 'should raise a number to a power when the word "power" is present' do
          expect(w.do_the_math(['4','2'], ['power'])).to eq 16
      end

      it 'should return an answer for multiple operations' do
          expect(w.do_the_math(['4', '6', '2'], ['plus', 'divided'])).to eq 5
      end
    end

    describe 'exclude_words' do
      it 'should remove any unnecessary words from the sentence' do
        expect(w.exclude_words('What is 4 to the 2nd power?')).to eq ['4', '2nd', 'power?']
      end
    end

    describe 'strip_suffixes' do
      it 'should strip any suffixes' do
        expect(w.strip_suffixes(['4', '2nd', 'power?'])).to eq ['4', '2', 'power']
      end
    end

    describe 'separate nums from ops' do
      it 'should separate the numbers from the operators' do
        nums,ops = w.separate_nums_from_ops(['4', '2', 'power'])
        expect(nums).to eq ['4', '2']
        expect(ops).to eq ['power']
      end
    end
  end
end