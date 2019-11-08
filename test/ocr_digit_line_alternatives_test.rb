# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ocr_digit_line_alternatives'
require_relative '../lib/ocr_digit_line'

describe OcrDigitLineAlternatives do
  it 'returns expected alternatives for 111111111' do
    ocr = [
      '                           ',
      '  |  |  |  |  |  |  |  |  |',
      '  |  |  |  |  |  |  |  |  |'
    ]
    digit_line_obj = OcrDigitLine.new(ocr)
    alts_obj = OcrDigitLineAlternatives.new(digit_line_obj.ocr_digits)
    assert_equal ['711111111'].sort, alts_obj.alternatives.sort
    assert_equal '711111111', alts_obj.output_line
  end

  it 'returns expected alternatives for 111111111' do
    ocr = [
      ' _  _  _  _  _  _  _  _  _ ',
      '|_||_||_||_||_||_||_||_||_|',
      '|_||_||_||_||_||_||_||_||_|'
    ]
    digit_line_obj = OcrDigitLine.new(ocr)
    alts_obj = OcrDigitLineAlternatives.new(digit_line_obj.ocr_digits)
    assert_equal %w[888886888 888888880 888888988].sort,
                 alts_obj.alternatives.sort
    assert_equal "888888888 AMB ['888886888', '888888988', '888888880']",
                 alts_obj.output_line
  end

  it 'returns expected alternatives for 49086717?' do
    ocr = [
      '    _  _  _  _  _  _     _ ',
      '|_||_|| ||_||_   |  |  | _ ',
      '  | _||_||_||_|  |  |  | _|'
    ]
    digit_line_obj = OcrDigitLine.new(ocr)
    alts_obj = OcrDigitLineAlternatives.new(digit_line_obj.ocr_digits)
    assert_equal ['490867715'].sort, alts_obj.alternatives.sort
    assert_equal '490867715', alts_obj.output_line
  end
end
