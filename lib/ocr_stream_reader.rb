# frozen_string_literal: true

# Takes a filename as an input argument to build list of results
class OcrStreamReader
  attr_reader :input_lines

  def initialize(input)
    all_lines = input.readlines
    @input_lines = (0..(all_lines.size / 4)).map do |ocr_line_pos|
      file_pos = ocr_line_pos * 4
      [
        cleanup_line(all_lines[file_pos]),
        cleanup_line(all_lines[file_pos + 1]),
        cleanup_line(all_lines[file_pos + 2])
      ]
    end
  end

  private

  def cleanup_line(str)
    remove_trailing_newline(str).ljust(27, ' ')
  end

  def remove_trailing_newline(str)
    return str unless str[-1] == "\n"

    str[0...-1]
  end
end
