module TimePup
  # Parses time with the following keywords;
  # year y
  # month mo
  # week w
  # day d
  # hour h
  # minute m

  class IncrementalTime
    MATCHERS = {
      years:    /(\d{1,2})ye?a?r?s?/,
      months:   /(\d{1,2})mo[a-zA-Z]*/,
      weeks:    /(\d{1,2})we?e?k?s?/,
      days:     /(\d{1,2}(\.\d{1,2})?)da?y?s?/,
      hours:    /(\d{1,2}(\.\d{1,2})?)ho?u?r?s?/,
      minutes:  /(\d{1,2})(?!(mo|mar))m[a-zA-Z]*/
    }

    class << self
      def parse(time)
        increment = match_and_return_time(time.downcase)
        increment == 0.seconds ? nil : increment.from_now
      end

      def match_and_return_time(time)
        MATCHERS.keys.inject(0.seconds) do |result, m|
          result += scan_increments(time, m)
        end
      end

      def scan_increments(time, unit)
        increments = time.scan MATCHERS[unit]
        if increments.empty?
          0.seconds
        else
          if unit == :hours || unit == :days
            increments.first[0].to_f.send(unit.to_sym)
          else
            increments.first[0].to_i.send(unit.to_sym)
          end
        end
      end
    end
  end
end

