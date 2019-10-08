# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ocr_digit.rb'

describe OcrDigit do
  it 'should identify 1 correctly' do
    ocr1 = [
      '   ',
      '  |',
      '  |'
    ]
    assert_equal '1', OcrDigit.new(ocr1).digit_string
  end

  it 'should return ? for unknown digit' do
    ocr_unknown = [
      ' _ ',
      ' _ ',
      '|_|'
    ]
    assert_equal '?', OcrDigit.new(ocr_unknown).digit_string
  end

  it 'should pad strings with spaces when too short (9)' do
    ocr = [
      ' _',
      '|_|',
      ' _|'
    ]
    assert_equal '9', OcrDigit.new(ocr).digit_string
  end

  it 'should pad strings with spaces when too short' do
    ocr = [
      ' _',
      '  |',
      '  |'
    ]
    assert_equal '7', OcrDigit.new(ocr).digit_string
  end

  it 'should raise when given incorrect sized input' do
    bad_ocr = [
      '   ',
      '  |',
      ' | |'
    ]
    assert_raises StandardError do
      OcrDigit.new(bad_ocr)
    end
  end
end
