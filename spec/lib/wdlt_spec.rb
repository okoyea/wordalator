require 'spec_helper'
require 'wordalator/wdlt'

module Wordalator
  describe WDLT do
    describe 'parse' do
      let(:w) { WDLT.new(query) }

      context 'when only one sentence exists' do
        let(:query) { ['What is 10 divided by 2?'] }

        it 'should return the correct result' do
          expect(w.parse).to eq 5
        end
      end

      context 'when there are multiple operators in one sentence' do
        let(:query) { ['What is 4 plus 10 divided by 2?'] }

        it 'should return the correct results' do
          expect(w.parse).to eq 7
        end
      end

      context 'when there are multiple sentences' do
        let(:query) { ['What is 10 divided by 2?','What is 4 plus 10 divided by 2?',' What is 4 to the 2nd power?'] }

        it 'should return the correct results' do
          expect(w.parse).to eq [5, 7, 16]
        end
      end

      context 'when the solution is a decimal number' do
        let(:query) { ['What is 4 plus 10 plus 5 divided by 2?'] }

        it 'should return the correct results' do
          expect(w.parse).to eq 9.5
        end
      end

      context 'when the solution is a decimal number' do
        let(:query) { ['What is 4 plus 10 plus 5 divided by 2?'] }

        it 'should return the correct results' do
          expect(w.parse).to eq 9.5
        end
      end

      context 'when there are too few numbers' do
        let(:query) { ['What is 5 minus?'] }

        it 'should raise an error' do
          lambda {w.parse}.should raise_error(ArgumentError)
        end
      end

      context 'when there are too few operators' do
        let(:query) { ['What is 5 2?'] }

        it 'should raise an error' do
          lambda {w.parse}.should raise_error(ArgumentError)
        end
      end
    end
  end
end