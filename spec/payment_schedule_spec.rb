require 'spec_helper'
include Scheduling

describe PaymentSchedule do
  context 'regular schedule' do
    context 'yearly' do
      context 'date range given covers exactly 1 year' do
        it 'should produce one payment on the expected date' do
          paysched = PaymentSchedule.new(
            100, RegularSchedule.new(Yearly.new(11,20), Date.new(2012,5,30)...Date.new(2013,5,30))
          )
          payments = paysched.payments(paysched.schedule.date_range)
          payments.count.should eq(1)
          payments.first[0].should eq(Date.new(2012,11,20))
          payments.first[1].should eq(100)
        end
      end

      context 'date range given covers exactly 10 years' do
        it 'should produce 10 payments on the expected dates, for the same amount' do
          amount = 25.10
          month, day = 6, 13
          paysched = PaymentSchedule.new(
            amount, RegularSchedule.new(Yearly.new(month,day), Date.new(2000,2,14)...Date.new(2010,2,14))
          )
          payments = paysched.payments(paysched.schedule.date_range)
          payments.count.should eq(10)
          
          payments.each do |date,amt|
            date.month.should eq(month)
            date.day.should eq(day)
            amt.should eq(amount)
          end

          dates = payments.keys
          for i in 1...dates.count
            (dates[i].year - dates[i-1].year).should eq(1)
          end
        end
      end
    end

    context 'monthly' do
      context 'date range given covers exactly 1 month' do
        it 'should produce one payment on the expected date' do
          paysched = PaymentSchedule.new(
            100, RegularSchedule.new(Monthly.new(14), Date.new(1965,11,24)...Date.new(1965,12,24))
          )
          payments = paysched.payments(paysched.schedule.date_range)
          payments.count.should eq(1)
          payments.first[0].should eq(Date.new(1965,12,14))
          payments.first[1].should eq(100)
        end
      end

      context 'date range given covers exactly 1 year' do
        it 'should produce 12 payments on the expected dates, for the same amount' do
          amount = 462.11
          day = 13
          paysched = PaymentSchedule.new(
            amount, RegularSchedule.new(Monthly.new(day), Date.new(1776,4,30)...Date.new(1777,4,30))
          )
          payments = paysched.payments(paysched.schedule.date_range)
          payments.count.should eq(12)
          
          payments.each do |date,amt|
            date.day.should eq(day)
            amt.should eq(amount)
          end

          dates = payments.keys
          for i in 1...dates.count
            if dates[i-1].month == 12
              dates[i].month.should eq(1)
            else
              (dates[i].month - dates[i-1].month).should eq(1)
            end
          end
        end
      end
    end
  end
end