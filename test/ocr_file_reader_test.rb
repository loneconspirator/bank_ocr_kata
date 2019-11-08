# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ocr_file_reader'

describe OcrFileReader do
  it 'returns expected results from test_file' do
    output = OcrFileReader.new('test_file.txt').input_lines
    zeros = [
      ' _  _  _  _  _  _  _  _  _ ',
      '| || || || || || || || || |',
      '|_||_||_||_||_||_||_||_||_|'
    ]
    assert_equal zeros, output[0]
    ones = [
      '                           ',
      '  |  |  |  |  |  |  |  |  |',
      '  |  |  |  |  |  |  |  |  |'
    ]
    assert_equal ones, output[1]
  end
end
