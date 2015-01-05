require 'wordalator/wdlt_constants'
require 'wordalator/wdlt_query_processor'
require 'active_model'


module Wordalator
  class WDLT
    include WDLTConstants
    include ActiveModel::Validations

    validates_presence_of :query

    attr_accessor :queries

    def initialize(queries)
      @queries = queries
    end

    def do_the_math(nums, ops)

      #validations
      #nums cant be less than one integer
      #ops must always be one less that the count of nums

      #to ensure we can calculate decimal numbers
      nums.map!(&:to_f)

      #initial result
      result = nums[0].send(MATCHERS[ops[0]],nums[1])

      #for multiple operations in one sentence
      #uses the initial result to do any extra calculations
      if ops.count > 1
        ops[1..-1].each_with_index do |op, i|
          j = i+2
          result = result.send(MATCHERS[op],nums[j])
        end
      end

      result
    end

    def parse
      results = []

      queries.each do |q|
        nums,ops = WDLTQueryProcessor.new(q).process

        if (queries.count > 1)
          results << do_the_math(nums, ops)
        else
          results = do_the_math(nums, ops)
        end
      end

      results
    end
  end
end