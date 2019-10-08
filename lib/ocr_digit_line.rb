# frozen_string_literal: true

require_relative 'ocr_digit'

# Processes a line of OCR digits represented as an array of three strings
# (the input lines)
class OcrDigitLine
  attr_reader :digit_line

  def initialize(lines)
    raise if bad_ocr_shape(lines)

    @digit_line = interpret_line(lines)
  end

  private

  def bad_ocr_shape(lines)
    return true unless lines.size == 3

    lines.each do |line|
      return true unless [27, 26].include?(line.size)
    end
    false
  end

  def interpret_line(ocr_lines)
    ocr_digits = split_ocr_lines(ocr_lines)
    ocr_digits.map { |ocr| OcrDigit.new(ocr).digit_string }.join('')
  end

  def split_ocr_lines(ocr_lines)
    (0..8).map do |pos|
      ocr_lines.map { |line| line[(pos * 3)..(pos * 3 + 2)] }
    end
  end
end
