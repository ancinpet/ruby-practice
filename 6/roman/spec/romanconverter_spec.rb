# frozen_string_literal: true

require 'roman/romanconverter.rb'

describe RomanConverter do
  subject { described_class.new }

  describe 'when asked to convert a nice arabic number into an arabic format' do
    it 'converts it fine' do
      expect(subject.make_arabic(42)).to eq 42
      expect(subject.make_arabic(97)).to eq 97
      expect(subject.make_arabic(899)).to eq 899
      expect(subject.make_arabic(1000)).to eq 1000
    end
  end

  describe 'when asked to convert an out of bound arabic number into an arabic format' do
    it 'gives an invalid argument range error' do
      expect(subject.make_arabic(1001)).to eq 'Invalid Argument Range'
      expect(subject.make_arabic(0)).to eq 'Invalid Argument Range'
      expect(subject.make_arabic('0')).to eq 'Invalid Argument Range'
      expect(subject.make_arabic(-1)).to eq 'Invalid Argument Range'
      expect(subject.make_arabic(-42)).to eq 'Invalid Argument Range'
      expect(subject.make_arabic(-1000)).to eq 'Invalid Argument Range'
      expect(subject.make_arabic(-1001)).to eq 'Invalid Argument Range'
    end
  end

  describe 'when asked to convert a nice roman number into an arabic format' do
    it 'converts it fine' do
      expect(subject.make_arabic('IV')).to eq 4
      expect(subject.make_arabic("XLII")).to eq 42
      expect(subject.make_arabic("xlii")).to eq 42
      expect(subject.make_arabic("XlIi")).to eq 42
      expect(subject.make_arabic('III')).to eq 3
      expect(subject.make_arabic('I')).to eq 1
      expect(subject.make_arabic('V')).to eq 5
      expect(subject.make_arabic('X')).to eq 10
      expect(subject.make_arabic('L')).to eq 50
      expect(subject.make_arabic('C')).to eq 100
      expect(subject.make_arabic('D')).to eq 500
      expect(subject.make_arabic('M')).to eq 1000
      expect(subject.make_arabic('XLIX')).to eq 49
      expect(subject.make_arabic('IC')).to eq 99
      expect(subject.make_arabic('ID')).to eq 499
      expect(subject.make_arabic('IM')).to eq 999
    end
  end

  describe 'when asked to convert an out of bound roman number into an arabic format' do
    it 'gives an invalid argument range error' do
      expect(subject.make_arabic('MI')).to eq 'Invalid Argument Range'
      expect(subject.make_arabic('MM')).to eq 'Invalid Argument Range'
      expect(subject.make_arabic('MC')).to eq 'Invalid Argument Range'
      expect(subject.make_arabic('MD')).to eq 'Invalid Argument Range'
    end
  end

  describe 'when asked to convert a nonsense into an arabic format' do
    it 'gives an invalid argument error' do
      expect(subject.make_arabic('')).to eq 'Invalid Argument Range'
      expect(subject.make_arabic(self.class.new)).to eq 'Invalid Argument'
      expect(subject.make_arabic('BLA')).to eq 'Invalid Argument'
      expect(subject.make_arabic('-I')).to eq 'Invalid Argument'
      expect(subject.make_arabic('-XX')).to eq 'Invalid Argument'
      expect(subject.make_arabic('-M')).to eq 'Invalid Argument'
      expect(subject.make_arabic('+I')).to eq 'Invalid Argument'
      expect(subject.make_arabic('nil')).to eq 'Invalid Argument'
      expect(subject.make_arabic(nil)).to eq 'Invalid Argument'
    end
  end

  describe 'when asked to convert a nice arabic number into a roman format' do
    it 'converts it fine' do
      expect(subject.make_roman(42)).to eq 'XLII'
      expect(subject.make_roman(97)).to eq 'XCVII'
      expect(subject.make_roman(899)).to eq 'DCCCXCIX'
      expect(subject.make_roman(1000)).to eq 'M'
    end
  end

  describe 'when asked to convert an out of bound arabic number into a roman format' do
    it 'gives an invalid argument range error' do
      expect(subject.make_roman(1001)).to eq 'Invalid Argument Range'
      expect(subject.make_roman(0)).to eq 'Invalid Argument Range'
      expect(subject.make_roman('0')).to eq 'Invalid Argument Range'
      expect(subject.make_roman(-1)).to eq 'Invalid Argument Range'
      expect(subject.make_roman(-42)).to eq 'Invalid Argument Range'
      expect(subject.make_roman(-1000)).to eq 'Invalid Argument Range'
      expect(subject.make_roman(-1001)).to eq 'Invalid Argument Range'
    end
  end

  describe 'when asked to convert a nice roman number into a roman format' do
    it 'converts it fine' do
      expect(subject.make_roman('IV')).to eq 'IV'
      expect(subject.make_roman("XLII")).to eq 'XLII'
      expect(subject.make_roman("xlii")).to eq 'XLII'
      expect(subject.make_roman("XlIi")).to eq 'XLII'
      expect(subject.make_roman('III')).to eq 'III'
      expect(subject.make_roman('I')).to eq 'I'
      expect(subject.make_roman('V')).to eq 'V'
      expect(subject.make_roman('X')).to eq 'X'
      expect(subject.make_roman('L')).to eq 'L'
      expect(subject.make_roman('C')).to eq 'C'
      expect(subject.make_roman('D')).to eq 'D'
      expect(subject.make_roman('M')).to eq 'M'
      expect(subject.make_roman('XLIX')).to eq 'XLIX'
    end
  end

  describe 'when asked to convert an out of bound roman number into a roman format' do
    it 'gives an invalid argument range error' do
      expect(subject.make_roman('MI')).to eq 'Invalid Argument Range'
      expect(subject.make_roman('MM')).to eq 'Invalid Argument Range'
      expect(subject.make_roman('MC')).to eq 'Invalid Argument Range'
      expect(subject.make_roman('MD')).to eq 'Invalid Argument Range'
    end
  end

  describe 'when asked to convert a nonsense into a roman format' do
    it 'gives an invalid argument error' do
      expect(subject.make_roman('')).to eq 'Invalid Argument Range'
      expect(subject.make_roman(self.class.new)).to eq 'Invalid Argument'
      expect(subject.make_roman('BLA')).to eq 'Invalid Argument'
      expect(subject.make_roman('-I')).to eq 'Invalid Argument'
      expect(subject.make_roman('-XX')).to eq 'Invalid Argument'
      expect(subject.make_roman('-M')).to eq 'Invalid Argument'
      expect(subject.make_roman('+I')).to eq 'Invalid Argument'
      expect(subject.make_roman('nil')).to eq 'Invalid Argument'
      expect(subject.make_roman(nil)).to eq 'Invalid Argument'
    end
  end
end
