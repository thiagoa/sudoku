require 'sudoku/board_validator/result'

module Sudoku
  class BoardValidator
    def initialize(board)
      @board = board
    end

    def call
      Result.new(result)
    end

    private

    def result
      return :invalid if not valid?
      return :incomplete if incomplete?

      :valid
    end

    def valid?
      [@board.rows, @board.columns, @board.grids].all? do |matrix|
        valid_matrix?(matrix)
      end
    end

    def valid_matrix?(matrix)
      matrix.all? { |row| set?(row.reject(&:zero?)) }
    end

    def set?(row)
      row.uniq.length == row.length
    end

    def incomplete?
      @board.rows.flatten.any?(&:zero?)
    end
  end
end
