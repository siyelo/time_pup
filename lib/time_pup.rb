require "time_pup/version"

module TimePup
  require 'active_support/core_ext/numeric/time'
  require 'active_support/core_ext/integer/time'
  require 'active_support/values/time_zone'
  require 'active_support/time_with_zone'
  require 'active_support/core_ext/time/calculations'
  require 'active_support/core_ext/date_time/calculations'
  require 'active_support/core_ext/date/calculations'
  require 'active_support/core_ext/date_time/zones'

  require 'time_pup/adverb_parser'
  require 'time_pup/time_parser'
  require 'time_pup/incremental_time'
  require 'time_pup/date_time_parser'

  def self.parse(time, timezone = 'UTC')
    TimePup::AdverbParser.parse(time, timezone) ||
      TimePup::DateTimeParser.parse(time, timezone) ||
      TimePup::IncrementalTime.parse(time) ||
      TimePup::TimeParser.parse(time, timezone)
  end
end
