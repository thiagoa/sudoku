require 'sudoku/board_error'
require 'sudoku/board_validator'
require 'sudoku/grid_extractor'

module Sudoku
  class Board
    SIZE = 9
    VALID_NUMBERS = 0..9

    attr_reader :rows

    def initialize(rows)
      @rows = rows

      fail BoardError, "Size needs to be #{SIZE}x#{SIZE}" if not correct_size?
      fail BoardError, "Out of range numbers" if not correct_numbers?
    end

    def columns
      @columns ||= rows.transpose
    end

    def grids
      @grids ||= SIZE.times.map { |number| grid_extractor.call(number) }
    end

    def validate
      BoardValidator.new(self).call
    end

    private

    def correct_size?
      return false if rows.empty?

      rows.first.count == SIZE && rows.count == SIZE
    end

    def correct_numbers?
      @rows.flatten.all? { |number| VALID_NUMBERS.cover?(number) }
    end

    def grid_extractor
      @grid_extractor ||= GridExtractor.new(self)
    end
  end
end
