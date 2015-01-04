require 'wordalator/wdlt_constants'

class WDLTQueryProcessor
  include WDLTConstants

  attr_accessor :query

  def initialize(query)
    @query = query
  end

  def process
    @query = exclude_words
    strip_suffixes
    separate_nums_and_ops
  end

  def exclude_words
    @query.split - COMPARATORS
  end

  def strip_suffixes
    @query.map!{|e| e.sub(/^r(?=d).|t(?=h).|n(?=d).|s(?=t).|[-?]/, '')}
  end

  def separate_nums_and_ops
    nums = []
    ops = []

    @query.each do |str|
      if /\d/.match(str)
        nums << str
      elsif /\D/.match(str)
        ops << str
      end
    end

    return nums, ops
  end
end
