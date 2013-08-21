require 'terminal-table'

module Finance
# Allocate an amount of some resource for various purposes
class Budget
  class AmountNotPositiveError < StandardError; end
  
  attr_reader :allocations

  def initialize allocations = {}
    allocations.each do |purpose,item|
      unless item.is_a? Budget
        raise AmountNotPositiveError if item <= 0
      end
    end
    @allocations = allocations
  end

  def total
    total = 0
    allocations.each do |purpose,item|
      if item.is_a? Budget
        total += item.total
      else
        total += item
      end
    end
    return total
  end

  def to_s title = ""
    args = { :headings => ['Item','Amount'], :rows => allocations.to_a}
    unless title.empty?
      args[:title] = title
    end
    t = Terminal::Table.new(args)
    t.add_separator
    t.add_row ['Total',total]
    t.to_s
  end
end
end