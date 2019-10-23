# frozen_string_literal: true

require 'pry'
require_relative 'ocr_digit_line'
require_relative 'ocr_digit_alternatives'

# Finds alternative valid digit lines for a given scan
class OcrDigitLineAlternatives
  attr_accessor :alternatives, :status, :output_line

  def initialize(digit_scans)
    @alternatives = (0...9).map { |pos| options_swapping(pos, digit_scans) }
                           .flatten.compact
    @status = 'ILL' if @alternatives.empty?
    @status = 'AMB' if @alternatives.length > 1
    @output_line = build_output_line(digit_scans)
  end

  private

  def options_swapping(position, digit_scans)
    original = digit_scans.map(&:digit_string)
    OcrDigitAlternatives.new(digit_scans[position].digit_scan)
                        .alternatives.map do |alt|
      original[position] = alt
      test_line = original.join('')
      line_if_good(test_line)
    end
  end

  def line_if_good(line)
    line if OcrDigitLine.valid?(line) && !OcrDigitLine.illegible?(line)
  end

  def build_output_line(digit_scans)
    case @alternatives.length
    when 0
      value_and_status(digit_scans)
    when 1
      @alternatives[0].to_s
    else
      "#{value_and_status(digit_scans)} #{format_alts(@alternatives)}"
    end
  end

  def value_and_status(digit_scans)
    "#{digit_scans.map(&:digit_string).join('')} #{status}"
  end

  def format_alts(alts)
    '[' + alts.map { |val| "'#{val}'" }.join(', ') + ']'
  end
end
