require 'spec_helper'

describe 'Enumerable#sum' do
  context 'no initial sum given' do
    it 'should return the sum of the elements' do
      [1,2,3].sum.should eq(6)
      [-10,22,1.5,2000].sum.should eq(2013.5)
    end
  end

  context 'an initial sum is given' do
    it 'should return the sum of the elements plus the initial sum' do
      [1,2,3].sum(4).should eq(10)
      [-10,22,1.5,2000].sum(0.5).should eq(2014)
    end
  end
end