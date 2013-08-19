require 'scheduling'

module Finance
  class PaymentSchedule < Struct.new(:amount, :schedule)
    def payments date_range
      payments = {}
      schedule.occurances(date_range).each do |date|
        payments[date] = amount
      end
      return payments
    end

    def total_payment
      schedule.occurances(date_range).count * amount
    end
  end
end
