require 'sudoku/board'

module Sudoku
  class BoardParser
    def initialize(board_string, board_class = nil)
      @board_string = board_string
      @board_class = board_class || Board
    end

    def call
      @board_class.new(to_a)
    end

    private

    def to_a
      @board_string
        .each_line
        .map { |line| line.scan(/\d/).map(&:to_i) }
        .reject(&:empty?)
    end
  end
end
