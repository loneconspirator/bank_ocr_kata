# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/focus'
require_relative '../lib/ocr_digit_alternatives'

describe OcrDigitAlternatives do
  it 'should give expected alternatives for 7' do
    oda = OcrDigitAlternatives.new([' _ ',
                                    '  |',
                                    '  |'])
    assert_equal(['1'], oda.alternatives)
  end

  it 'should give expected results for 9' do
    oda = OcrDigitAlternatives.new([' _ ',
                                    '|_|',
                                    ' _|'])
    assert_equal(%w[3 5 8], oda.alternatives)
  end
end
