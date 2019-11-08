# frozen_string_literal: true

require_relative 'ocr_digit'

# Provide alternative options for digit interpretation from a single change
class OcrDigitAlternatives
  attr_accessor :alternatives

  def initialize(digit_scan)
    @alternatives = swap_results(digit_scan).compact
  end

  private

  CELL_OPTIONS = [' _ ',
                  '|_|',
                  '|_|'].freeze

  def swap_results(digit_scan)
    results = []
    (0..2).each do |x|
      (0..2).each do |y|
        results << try_toggling(digit_scan, x, y)
      end
    end
    results
  end

  def try_toggling(digit_scan, row, col)
    toggle_value = CELL_OPTIONS[row][col]
    return nil if toggle_value == ' '

    toggled_digit = toggle_digit(digit_scan, row, col, toggle_value)
    alt_digit = OcrDigit.new(toggled_digit).digit_string
    return nil if alt_digit == '?'

    alt_digit
  end

  def toggle_digit(digit_scan, row, col, toggle)
    new_char = if digit_scan[row][col] == ' '
                 toggle
               else
                 ' '
               end
    # An inelegant workaround for ruby's string sharing
    new_digit = digit_scan.dup
    new_row = digit_scan[row].split('')
    new_row[col] = new_char
    new_digit[row] = new_row.join('')
    new_digit
  end
end
