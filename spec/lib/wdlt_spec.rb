require 'spec_helper'
require 'wordalator/wdlt'

module Wordalator
  describe WDLT do
    let(:w) { WDLT.new('dummy query') }

    describe 'parse' do
      def do_parse(queries)
        w = WDLT.new(queries)
        w.parse
      end

      it 'should return the correct result when there is only one sentence' do
        expect(do_parse(['What is 10 divided by 2?'])).to eq 5
      end

      it 'should return the correct results when there are multiple operators in one sentence' do
        expect(do_parse(['What is 4 plus 10 divided by 2?'])).to eq 7
      end

      it 'should return the correct results when there are multiple sentences' do
        results = do_parse(['What is 10 divided by 2?','What is 4 plus 10 divided by 2?',' What is 4 to the 2nd power?'])
        expect(results).to eq [5, 7, 16]
      end

      it 'should return the correct results when the solution is a decimal number' do
        expect(do_parse(['What is 4 plus 10 plus 5 divided by 2?'])).to eq 9.5
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
  end
end