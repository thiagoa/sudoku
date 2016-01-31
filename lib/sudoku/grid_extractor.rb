require 'sudoku/board_error'

module Sudoku
  class GridExtractor
    SIZE = 3

    def initialize(board)
      @board = board
    end

    def call(grid_number)
      fail BoardError unless valid_grid_number?(grid_number)

      board_rows_third(grid_number).flat_map do |row|
        grid_third(grid_number, row)
      end
    end

    private

    def valid_grid_number?(number)
      (0...SIZE ** 2).cover? number
    end

    def board_rows_third(grid_number)
      extract(@board.rows, (grid_number / SIZE) * SIZE)
    end

    def grid_third(grid_number, row)
      extract(row, (grid_number % SIZE) * SIZE)
    end

    def extract(array, offset)
      array.drop(offset).take(SIZE)
    end
  end
end
