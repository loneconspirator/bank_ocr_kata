# frozen_string_literal: true

require_relative 'ocr_digit'

# Processes a line of OCR digits represented as an array of three strings
# (the input lines)
class OcrDigitLine
  attr_reader :ocr_digits, :digit_line, :valid, :status, :output_line

  def initialize(lines)
    raise if bad_ocr_shape(lines)

    @ocr_digits = build_ocr_digits(lines)
    @digit_line = @ocr_digits.map(&:digit_string).join('')
    @valid = !self.class.illegible?(@digit_line) &&
             self.class.valid?(@digit_line)
    @status = self.class.status(@digit_line)
    @output_line = "#{@digit_line} #{@status}".strip
  end

  class << self
    def valid?(digit_string)
      perform_checksum(digit_string)
    end

    def illegible?(digit_string)
      digit_string.include?('?')
    end

    def status(digit_string)
      return 'ILL' if illegible?(digit_string)
      return 'ERR' unless valid?(digit_string)

      ''
    end
  end

  private

  def bad_ocr_shape(lines)
    return true unless lines.size == 3

    lines.each do |line|
      return true unless [27, 26].include?(line.size)
    end
    false
  end

  def build_ocr_digits(ocr_lines)
    ocr_digits = split_ocr_lines(ocr_lines)
    ocr_digits.map { |ocr| OcrDigit.new(ocr) }
  end

  def split_ocr_lines(ocr_lines)
    (0..8).map do |pos|
      ocr_lines.map { |line| line[(pos * 3)..(pos * 3 + 2)] }
    end
  end

  class << self
    def perform_checksum(digit_string)
      ints = digit_string.split('').map(&:to_i)
      sum = (0...9).map { |i| ints[i] * (9 - i) }.sum
      (sum % 11).zero?
    end
  end
end
