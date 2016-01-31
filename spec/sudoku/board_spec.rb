require 'sudoku/board'
require 'sudoku/board_validator'

module Sudoku
  RSpec.describe Board do
    describe '.new' do
      it 'throws an error with an empty board' do
        expect { Board.new([]) }.to raise_error(BoardError)
      end

      it 'throws an error with 3x3 dimensions' do
        expect {
          Board.new(dummy_board_rows(width: 3, height: 3))
        }.to raise_error(BoardError)
      end

      it 'throws an error with 6x6 dimensions' do
        expect {
          Board.new(dummy_board_rows(width: 6, height: 6))
        }.to raise_error(BoardError)
      end

      it 'does not throw an error with 9x9 dimensions' do
        expect {
          Board.new(dummy_board_rows(width: 9, height: 9))
        }.not_to raise_error
      end

      it 'throws an error with non square dimension' do
        expect {
          Board.new(dummy_board_rows(width: 9, height: 7))
        }.to raise_error(BoardError)
      end

      it 'throws an error with 12x12 dimensions' do
        expect {
          Board.new(dummy_board_rows(width: 12, height: 12))
        }.to raise_error(BoardError)
      end

      it 'throws an error when the board has numbers smaller than 0' do
        rows = dummy_board_rows(width: 9, height: 9)
        rows[0][1] = -1

        expect { Board.new(rows) }.to raise_error(BoardError)
      end

      it 'throws an error when the board has numbers bigger than 9' do
        rows = dummy_board_rows(width: 9, height: 9)
        rows[2][0] = 10

        expect { Board.new(rows) }.to raise_error(BoardError)
      end
    end

    describe '#rows' do
      it 'returns its rows' do
        rows = dummy_board_rows(width: 9, height: 9)
        board = Board.new(rows)

        expect(board.rows).to eq rows
      end
    end

    CORRECT_BOARD_SAMPLE = [
      [1, 9, 1, 9, 1, 9, 1, 9, 1],
      [2, 8, 2, 8, 2, 8, 2, 8, 2],
      [3, 7, 3, 7, 3, 7, 3, 7, 0],
      [4, 6, 4, 6, 4, 6, 4, 0, 4],
      [5, 5, 5, 5, 5, 5, 0, 5, 5],
      [6, 4, 6, 4, 6, 0, 6, 4, 6],
      [7, 3, 7, 3, 0, 3, 7, 3, 7],
      [8, 2, 8, 0, 8, 2, 8, 2, 8],
      [9, 1, 0, 1, 9, 1, 9, 1, 9]
    ]

    describe '#columns' do
      it 'returns its columns' do
        board = Board.new(CORRECT_BOARD_SAMPLE)

        expect(board.columns).to eq [
          [1, 2, 3, 4, 5, 6, 7, 8, 9],
          [9, 8, 7, 6, 5, 4, 3, 2, 1],
          [1, 2, 3, 4, 5, 6, 7, 8, 0],
          [9, 8, 7, 6, 5, 4, 3, 0, 1],
          [1, 2, 3, 4, 5, 6, 0, 8, 9],
          [9, 8, 7, 6, 5, 0, 3, 2, 1],
          [1, 2, 3, 4, 0, 6, 7, 8, 9],
          [9, 8, 7, 0, 5, 4, 3, 2, 1],
          [1, 2, 0, 4, 5, 6, 7, 8, 9]
        ]
      end
    end

    describe '#grids' do
      it 'returns its grids' do
        board = Board.new(CORRECT_BOARD_SAMPLE)

        expect(board.grids).to eq [
          [1, 9, 1, 2, 8, 2, 3, 7, 3],
          [9, 1, 9, 8, 2, 8, 7, 3, 7],
          [1, 9, 1, 2, 8, 2, 3, 7, 0],
          [4, 6, 4, 5, 5, 5, 6, 4, 6],
          [6, 4, 6, 5, 5, 5, 4, 6, 0],
          [4, 0, 4, 0, 5, 5, 6, 4, 6],
          [7, 3, 7, 8, 2, 8, 9, 1, 0],
          [3, 0, 3, 0, 8, 2, 1, 9, 1],
          [7, 3, 7, 8, 2, 8, 9, 1, 9]
        ]
      end
    end

    describe '#validate' do
      it 'delegates to the validator class' do
        board = Board.new(CORRECT_BOARD_SAMPLE)

        validator_results = board_validator_results_double
        board_validator = board_validator_double(board, validator_results)

        expect(board.validate).to eq validator_results
      end
    end

    def dummy_board_rows(width:, height:)
      height.times.map { (1..width).to_a.shuffle }
    end

    def board_validator_double(board, results)
      validator = double('board_validator')
      allow(validator).to receive(:call).and_return(results)
      allow(BoardValidator).to receive(:new).with(board).and_return(validator)
    end

    def board_validator_results_double
      double('board_validator_results_double')
    end
  end
end
