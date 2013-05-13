module TimePup
  class DateTimeParser
    MONTHS = /jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec/i
    TIME = /\d{1,4}[a|p]m/i

    def self.parse(parsable, timezone = 'UTC')
      return nil unless parsable.match(MONTHS)
      date = DateTime.parse(parsable).to_time
      date = date.in_time_zone(ActiveSupport::TimeZone[timezone])
      time = find_time(parsable)
      if time
        date.change(hour: time.hour, min: time.min).utc
      else
        date.change(hour: 8).utc
      end
    end

    private
    def self.find_time(parsable)
      time_part = parsable.slice(TIME)
      TimePup::TimeParser.parse(time_part) if time_part
    end
  end
end
