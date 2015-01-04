require 'wordalator/wdlt_constants'

module Wordalator
  class WDLT
    include WDLTConstants

    attr_reader :query

    def initialize(query)
      @query = query
    end

    def exclude_words(q)
      q.split - COMPARATORS
    end

    def strip_suffixes(unstripped_array)
      unstripped_array.map!{|e| e.sub(/^r(?=d).|t(?=h).|n(?=d).|s(?=t).|[-?]/, '')}
    end

    def separate_nums_from_ops(stripped_array)
      nums = []
      ops = []

      stripped_array.each do |str|
        if /\d/.match(str)
          nums << str
        elsif /\D/.match(str)
          ops << str
        end
      end

      return nums, ops
    end

    def do_the_math(nums, ops)

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

    def process_input(q)
      strip_suffixes(exclude_words(q))
    end

    def parse
      results = []
      queries = @query.split('?')

      queries.each do |q|
        nums,ops = separate_nums_from_ops(process_input(q))

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