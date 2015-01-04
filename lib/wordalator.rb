# Usage:
#
#   Wordalate.parse "some query"
#

require "wordalator/version"
require "wordalator/wdlt"

module Wordalator
  class << self
    def parse(query)
      w = WDLT.new(query)
      w.parse
    end
  end
end
