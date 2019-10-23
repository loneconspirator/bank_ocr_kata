# frozen_string_literal: true

require_relative 'ocr_digit_line'

# Takes a filename as an input argument to build list of results
class OcrStreamReader
  attr_reader :input_lines

  def initialize(input)
    all_lines = input.readlines
    @input_lines = (0..(all_lines.size / 4)).map do |ocr_line_pos|
      file_pos = ocr_line_pos * 4
      [
        remove_trailing_newline(all_lines[file_pos]).ljust(27, ' '),
        remove_trailing_newline(all_lines[file_pos + 1]),
        remove_trailing_newline(all_lines[file_pos + 2])
      ]
    end
  end

  private

  def remove_trailing_newline(str)
    return str unless str[-1] == "\n"

    str[0...-1]
  end
end
