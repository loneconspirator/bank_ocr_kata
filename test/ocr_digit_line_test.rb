# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ocr_digit_line.rb'

describe OcrDigitLine do
  it 'returns expected value' do
    ocr = [
      '    _  _     _  _  _  _  _',
      '  | _| _||_||_ |_   ||_||_|',
      '  ||_  _|  | _||_|  ||_| _|'
    ]
    assert_equal '123456789', OcrDigitLine.new(ocr).digit_line
  end

  it 'raises error on poorly shaped input' do
    bad_ocr = [
      '  | _| _||_||_ |_   ||_||_|',
      '  ||_  _|  | _||_|  ||_| _|'
    ]
    assert_raises StandardError do
      OcrDigitLine.new(bad_ocr)
    end
  end
end