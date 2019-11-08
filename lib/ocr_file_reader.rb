# frozen_string_literal: true

require_relative 'ocr_stream_reader'

# Takes a filename as an input argument to build list of results
class OcrFileReader
  attr_reader :input_lines

  def initialize(filename)
    File.open(filename) do |file|
      @input_lines = OcrStreamReader.new(file).input_lines
    end
  end
end
