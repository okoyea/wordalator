# Usage:
#
#   Wordalate.parse "some query"
#

require "wordalator/version"
require "wordalator/wdlt"

module Wordalator
  class << self
    attr_accessor :queries

    def parse(*queries)
      w = WDLT.new(queries)
      w.parse
    end
  end
end
