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
    digit_line_obj = OcrDigitLine.new(ocr)
    assert_equal '123456789', digit_line_obj.digit_line
    assert_equal '', digit_line_obj.status
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

  it 'validates a good digit string' do
    assert OcrDigitLine.valid?('123456789')
  end

  it 'fails an invalid string' do
    assert_equal false, OcrDigitLine.valid?('664371495')
  end

  it 'sets correct status for invalid string' do
    assert_equal 'ERR', OcrDigitLine.status('664371495')
  end

  it 'fails an invalid string' do
    assert_equal 'ILL', OcrDigitLine.status('6643?1495')
  end
end
