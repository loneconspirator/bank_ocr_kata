# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ocr_stream_reader'

describe OcrStreamReader do
  it 'returns expected results from test_file' do
    File.open('test_file.txt') do |file|
      output = OcrStreamReader.new(file).input_lines
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
end
