module Finance
# Allocate an amount of some resource for various purposes
class Budget
  class AmountNotPositiveError < StandardError; end
  
  attr_reader :start_amount, :allocations

  def initialize start_amount, allocations = {}
    raise AmountNotPositiveError if start_amount <= 0
    @start_amount = start_amount

    allocations.each do |purpose,amount|
      raise AmountNotPositiveError if amount <= 0
    end
    @allocations = allocations
  end

  def total_allocation
    total = 0
    allocations.each do |purpose,amount|
      total += amount
    end
    return total
  end

  def net_flow
    return @start_amount - total_allocation
  end

  def balanced?
    net_flow == 0
  end

  def surplus?
    net_flow > 0
  end

  def deficit?
    net_flow < 0
  end
end
end