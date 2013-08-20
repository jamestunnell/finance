require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Budget do
  before :all do
    @allocations = {
      {:groceries => 250, :utilities => 300, :rent => 800} => 1350,
      {"R & D" => 1200000, "QA" => 400000, "Sales & Marketing" => 300000, "Facilities" => 80000} => 1980000,
    }
  end

  describe '#total_allocation' do
    it 'should sum all the allocation amounts' do
      @allocations.each do |allocations_hash, expected_total|
        Budget.new(1, allocations_hash).total_allocation.should eq(expected_total)
      end
    end
  end

  describe '#net_flow' do
    it 'should return the difference between start amount and total allocation' do
      [ 500,-1200,0,105030].each do |expected_net_flow|
        @allocations.each do |allocations_hash, expected_total|
          Budget.new(expected_total + expected_net_flow, allocations_hash).net_flow.should eq(expected_net_flow)
        end
      end
    end
  end

  describe '#balanced?' do
    context 'net_flow is 0' do
      it 'should return true' do
        @allocations.each do |allocations_hash, expected_total|
          Budget.new(expected_total, allocations_hash).balanced?.should be_true
        end
      end
    end

    context 'net_flow is not 0' do
      it 'should return false' do
        @allocations.each do |allocations_hash, expected_total|
          Budget.new(expected_total + rand(1..10), allocations_hash).balanced?.should be_false
          Budget.new(expected_total - rand(1..10), allocations_hash).balanced?.should be_false
        end
      end
    end
  end

  describe '#surplus?' do
    context 'net_flow is > 0' do
      it 'should return true' do
        @allocations.each do |allocations_hash, expected_total|
          Budget.new(expected_total + rand(1..10), allocations_hash).surplus?.should be_true
        end
      end
    end

    context 'net_flow is <= 0' do
      it 'should return false' do
        @allocations.each do |allocations_hash, expected_total|
          Budget.new(expected_total, allocations_hash).surplus?.should be_false
          Budget.new(expected_total - rand(1..10), allocations_hash).surplus?.should be_false
        end
      end
    end
  end

  describe '#deficit?' do
    context 'net_flow is < 0' do
      it 'should return true' do
        @allocations.each do |allocations_hash, expected_total|
          Budget.new(expected_total - rand(1..10), allocations_hash).deficit?.should be_true
        end
      end
    end

    context 'net_flow is >= 0' do
      it 'should return false' do
        @allocations.each do |allocations_hash, expected_total|
          Budget.new(expected_total, allocations_hash).deficit?.should be_false
          Budget.new(expected_total + rand(10), allocations_hash).deficit?.should be_false
        end
      end
    end
  end

end
