require 'spec_helper'
include Scheduling

describe PaymentSchedule do
  context 'regular schedule' do
    context 'yearly' do
      context 'date range given covers exactly 1 year' do
        it 'should produce one payment on the expected date' do
          paysched = PaymentSchedule.new(
            100, RegularSchedule.new(Yearly.new(11,20), Date.new(2012)...Date.new(2013))
          )
          payments = paysched.payments(paysched.schedule.date_range)
          payments.count.should eq(1)
          payments.first[0].should eq(Date.new(2012,11,20))
          payments.first[1].should eq(100)
        end
      end

      context 'date range given covers exactly 10 years' do
        it 'should produce 10 payments on the expected dates, for the same amount' do
          #PaymentSchedule.new().payments.should eq()
        end
      end
    end

    context 'monthly' do
      context 'date range given covers exactly 1 month' do
        it 'should produce one payment on the expected date' do
          #PaymentSchedule.new().payments.should eq()
        end
      end

      context 'date range given covers exactly 1 year' do
        it 'should produce 12 payments on the expected dates, for the same amount' do
          #PaymentSchedule.new().payments.should eq()
        end
      end
    end
  end
end