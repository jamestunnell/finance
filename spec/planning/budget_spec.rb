require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Budget do
  describe '#total' do
    context 'only numeric objects given for allocation values' do
      it 'should return the sum of the numeric objects' do
        Budget.new(:a => 25, :b => 32.5, :c => 1200).total.should eq(1257.5)
      end
    end

    context 'only Budget objects given for allocation values' do
      it 'should return the sum of all the Budget objects\' totals' do
        a = Budget.new(:a => 10, :b => 20)
        b = Budget.new(:a => 25, :b => 33)
        Budget.new(:a => a, :b => b).total.should eq(88)
      end
    end

    context 'mix of numeric and Budget objects given for allocation values' do
      it 'should return the sum of all the numeric objects and the Budget objects\' totals' do
        a = Budget.new(:a => 10, :b => 20)
        b = Budget.new(:a => 25, :b => 33)
        Budget.new(:a => a, :b => b, :c => 100, :d => 2).total.should eq(190)
      end
    end
  end
end
