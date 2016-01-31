require 'sudoku/board_parser'

module Sudoku
  RSpec.describe BoardParser do
    describe '#call' do
      it 'parses a string numbered board to an array' do
        board = board_double
        board_class = board_class_double(board, [
          [1, 1, 1, 3, 3, 3, 4, 4, 4],
          [2, 2, 2, 8, 8, 8, 9, 9, 9],
          [6, 6, 6, 5, 5, 5, 4, 4, 4],
          [7, 7, 7, 0, 0, 0, 8, 8, 8],
          [2, 2, 2, 8, 8, 8, 9, 9, 9],
          [1, 1, 1, 3, 3, 3, 4, 4, 4],
          [5, 5, 5, 2, 2, 2, 4, 4, 9],
          [0, 0, 0, 3, 3, 3, 1, 1, 1],
          [2, 2, 2, 8, 8, 8, 9, 9, 9]
        ])
        parser = BoardParser.new(<<-BOARD, board_class)
          1 1 1 3 3 3 4 4 4
          2 2 2 8 8 8 9 9 9
          6 6 6 5 5 5 4 4 4
          7 7 7 0 0 0 8 8 8
          2 2 2 8 8 8 9 9 9
          1 1 1 3 3 3 4 4 4
          5 5 5 2 2 2 4 4 9
          0 0 0 3 3 3 1 1 1
          2 2 2 8 8 8 9 9 9
        BOARD

        expect(parser.call).to eq(board)
      end

      it 'does not care when the string has non numeric characters' do
        board = board_double
        board_class = board_class_double(board, [
          [1, 1, 1, 3, 3, 3, 4, 4, 4],
          [2, 2, 2, 8, 8, 8, 9, 9, 9],
          [6, 6, 6, 5, 5, 5, 4, 4, 4],
          [7, 7, 7, 0, 0, 0, 8, 8, 8],
          [2, 2, 2, 8, 8, 8, 9, 9, 9],
          [1, 1, 1, 3, 3, 3, 4, 4, 4],
          [5, 5, 5, 2, 2, 2, 4, 4, 9],
          [0, 0, 0, 3, 3, 3, 1, 1, 1],
          [2, 2, 2, 8, 8, 8, 9, 9, 9]
        ])
        parser = BoardParser.new(<<-BOARD, board_class)
          -------------------------
          | 1 1 1 | 3 3 3 | 4 4 4 |
          | 2 2 2 | 8 8 8 | 9 9 9 |
          | 6 6 6 | 5 5 5 | 4 4 4 |
          | --------------------- |
          | 7 7 7 | 0 0 0 | 8 8 8 |
          | 2 2 2 | 8 8 8 | 9 9 9 |
          | 1 1 1 | 3 3 3 | 4 4 4 |
          | --------------------- |
          | 5 5 5 | 2 2 2 | 4 4 9 |
          | 0 0 0 | 3 3 3 | 1 1 1 |
          | 2 2 2 | 8 8 8 | 9 9 9 |
          -------------------------
        BOARD

        expect(parser.call).to eq(board)
      end
    end

    def board_class_double(board, board_rows)
      double('board_class').tap do |board_class|
        allow(board_class).to receive(:new)
          .with(board_rows)
          .and_return(board)
      end
    end
    
    def board_double
      double('board')
    end
  end
end
