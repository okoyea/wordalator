require 'wordalator/wdlt_constants'
require 'wordalator/wdlt_query_processor'
require 'active_model'


module Wordalator
  class WDLT
    include WDLTConstants
    include ActiveModel::Validations

    validates_presence_of :query

    attr_accessor :queries
    attr_reader :nums, :ops

    def initialize(queries)
      @queries = queries
    end

    def calculate
      #to ensure we can calculate decimal numbers
      @nums.map!(&:to_f)

      #initial result
      result = @nums[0].send(MATCHERS[@ops[0]],@nums[1])

      #for multiple operations in one sentence
      #uses the initial result to do any extra calculations
      if @ops.count > 1
        @ops[1..-1].each_with_index do |op, i|
          result = result.send(MATCHERS[op],@nums[i+2])
        end
      end

      result
    end

    def parse
      results = []

      @queries.each do |q|
        #call custom setter methods
        self.nums, self.ops = WDLTQueryProcessor.new(q).process

        # return an array only when there are multiple queries
        if (@queries.count > 1)
          results << calculate
        else
          results = calculate
        end
      end

      results
    end

    private

    def nums=(nums)
      @nums_count = nums.count

      if nums == nil || nums.count <= 1
        raise ArgumentError.new('A query must contain at least two numbers')
      end

      @nums = nums
    end

    def ops=(ops)
      if ops == nil || ops.count != @nums_count - 1
        raise ArgumentError.new('Too many operators exist in your query')
      end

      @ops = ops
    end
  end
end