module TimePup
  class TimeParser
    MATCHERS = {
      twelve_hour_with_period: /\d{1,4}[a|p]m/i,
      twenty_four_hour_with_minutes: /[0-2]{,1}\d[0-5]\d/,
      twenty_four_hour_without_minutes: /\d\d{,1}/,
    }
    AM_PM = /[a|p]m/i

    class << self
      def parse(parsable, zone = 'UTC')
        matches = match_key_words(parsable)
        if matches.empty?
          return nil
        else
          time_part = matches.first
          case time_part.length
          when 1..2
            time_part = time_part + ':00'
          when 3..4
            unless time_part.match(AM_PM)
              time_part = time_part.insert(-3,':')
            end
          when 5..6
            time_part = time_part.insert(-5,':')
          end

          return set_time_in_future(time_part, zone)
        end
      end

      def match_key_words(time)
        MATCHERS.keys.inject([]) { |result, m| result << time.scan(MATCHERS[m]) }.flatten
      end

      def set_time_in_future(time_part, zone)
        time = DateTime.parse(time_part)
        time_for_today = DateTime.now.to_time.in_time_zone(ActiveSupport::TimeZone[zone])
        time_for_today = time_for_today.change(hour: time.hour, min: time.min).utc
        if time_for_today < DateTime.now.to_time.utc
          time_for_today + 1.day
        else
          time_for_today
        end
      end
    end
  end
end
