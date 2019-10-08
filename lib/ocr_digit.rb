# frozen_string_literal: true

# OcrDigit is initialized with array of four strings of length 3 to
# determine what digit was OCR'd
class OcrDigit
  attr_reader :digit_string

  def initialize(ocr)
    raise 'Expecting array of 3 strings of length 3' if bad_ocr_shape(ocr)

    padded_ocr = pad_ocr(ocr)
    @digit_string = self.class.ocr_lookup[padded_ocr] || '?'
  end

  private


  def bad_ocr_shape(ocr)
    return true unless ocr.is_a?(Array)
    return true unless ocr.size == 3

    ocr.each do |str|
      return true unless str.is_a?(String)
      return true unless str.length <= 3
    end
    false
  end

  def pad_ocr(ocr)
    ocr.map { |str| str.ljust(3) }
  end

  class << self
    def ocr_lookup
      @ocr_lookup ||= build_ocr_lookup
    end

    def build_ocr_lookup
      reference_string_lines = ocr_reference_string.split("\n")
      lookup_hash = {}
      (0..10).map do |int|
        lookup_hash[
          reference_string_lines.map { |line| line[(3 * int)..(3 * int + 2)] }
        ] = int.to_s
      end
      lookup_hash
    end

    def ocr_reference_string
      <<~OCR_STRING
         _     _  _     _  _  _  _  _
        | |  | _| _||_||_ |_   ||_||_|
        |_|  ||_  _|  | _||_|  ||_| _|
      OCR_STRING
    end
  end
end
