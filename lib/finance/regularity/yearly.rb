require 'date'

module Finance
class Yearly
  def initialize time
    @time = time
  end

  def occurances time_range
    raise RangeDecreasingError if time_range.decreasing?

    cur = Date.new(time_range.min.year, @time.month, @time.day)

    start = time_range.min
    if cur < start
      cur = cur.next_year
    end

    occurances = []

    stop = time_range.last
    if time_range.exclude_end?
      stop -= 1
    end

    while cur <= stop
      occurances.push cur
      cur = cur.next_year
    end

    return occurances
  end
end
end
