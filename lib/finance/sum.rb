module Enumerable
  def sum initial_sum = 0
    each.inject(initial_sum){|sum,amt| sum + amt }
  end
end