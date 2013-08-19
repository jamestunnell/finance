require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Yearly do
  describe '#occurances' do
    context 'time range spans less than 1 year' do
      context 'original time not in yday range' do
        it 'should return empty array' do
          [
           {:original => Date.new(2000,1,15), :range => Date.new(2003,1,16)..Date.new(2004,1,14)},
           {:original => Date.new(2000,1,15), :range => Date.new(2003,1,14)...Date.new(2003,1,15)},
           {:original => Date.new(2002,2,2), :range => Date.new(2020,10,1)...Date.new(2021,2,1)},
          ].each do |case_hash|
            Yearly.new(case_hash[:original]).occurances(case_hash[:range]).should be_empty
          end
        end
      end

      context 'original time is in yday range' do
        it 'should return array with 1 element' do
          [
           {:original => Date.new(2000,1,15), :range => Date.new(2003,1,15)...Date.new(2003,1,16)},
           {:original => Date.new(2000,1,15), :range => Date.new(2003,1,14)..Date.new(2003,1,15)},
           {:original => Date.new(2013,4,10), :range => Date.new(2003,1,14)..Date.new(2003,5,15)},
           {:original => Date.new(2025,7,22), :range => Date.new(2003,3,1)..Date.new(2004,1,1)},
          ].each do |case_hash|
            Yearly.new(case_hash[:original]).occurances(case_hash[:range]).count.should eq(1)
          end
        end
      end
    end

    context 'time range spans more than 1 year but less than 2 years' do
      context 'original time not in yday range' do
        it 'should return array with 1 element' do
          [
           {:original => Date.new(2000,1,15), :range => Date.new(2003,1,16)..Date.new(2005,1,14)},
           {:original => Date.new(2000,1,15), :range => Date.new(2003,1,14)...Date.new(2004,1,15)},
           {:original => Date.new(2002,2,2), :range => Date.new(2020,10,1)...Date.new(2022,2,1)},
          ].each do |case_hash|
            Yearly.new(case_hash[:original]).occurances(case_hash[:range]).count.should eq(1)
          end
        end
      end

      context 'original time is in yday range' do
        it 'should return array with 2 elements' do
          [
           {:original => Date.new(2000,1,15), :range => Date.new(2003,1,15)...Date.new(2004,1,16)},
           {:original => Date.new(2000,1,15), :range => Date.new(2003,1,14)..Date.new(2004,1,15)},
           {:original => Date.new(2013,4,10), :range => Date.new(2003,1,14)..Date.new(2004,5,15)},
           {:original => Date.new(2025,7,22), :range => Date.new(2003,3,1)..Date.new(2005,1,1)},
          ].each do |case_hash|
            Yearly.new(case_hash[:original]).occurances(case_hash[:range]).count.should eq(2)
          end
        end
      end
    end
  end
end
