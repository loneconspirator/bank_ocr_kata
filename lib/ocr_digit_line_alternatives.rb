# frozen_string_literal: true

require 'pry'
require_relative 'ocr_digit_line'
require_relative 'ocr_digit_alternatives'

# Finds alternative valid digit lines for a given scan
class OcrDigitLineAlternatives
  attr_accessor :alternatives

  def initialize(digit_scans)
    @alternatives = (0...9).map { |pos| options_swapping(pos, digit_scans) }
                           .flatten.compact
  end

  private

  def options_swapping(position, digit_scans)
    original = digit_scans.map(&:digit_string)
    begin
      OcrDigitAlternatives.new(digit_scans[position].digit_scan)
                          .alternatives.map do |alt|
        original[position] = alt
        test_line = original.join('')
        line_if_good(test_line)
      end
    rescue StandardError => e
      # binding.pry
    end
  end

  def line_if_good(line)
    line if OcrDigitLine.valid?(line) && !OcrDigitLine.illegible?(line)
  end
end
