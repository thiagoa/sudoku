require 'sudoku/board_validator'
require 'sudoku/board'

module Sudoku
  RSpec.describe BoardValidator do
    describe '#call' do
      context 'when board has unique numbers in rows, columns and grids' do
        it 'is valid' do
          board = board_double(
            rows: valid_number_rows,
            columns: valid_number_rows,
            grids: valid_number_rows
          )
          validator = BoardValidator.new(board)

          expect(validator.call).to be_valid
        end
      end

      context 'when board is valid but has zeros in its rows' do
        it 'is incomplete' do
          board = board_double(
            rows: valid_incomplete_number_rows,
            columns: valid_number_rows,
            grids: valid_number_rows
          )
          validator = BoardValidator.new(board)

          expect(validator.call).to be_incomplete
        end
      end

      context 'when only board rows have number repetition' do
        it 'is invalid' do
          board = board_double(
            rows: invalid_number_rows,
            columns: valid_number_rows,
            grids: valid_number_rows
          )
          validator = BoardValidator.new(board)

          expect(validator.call).to be_invalid
        end
      end

      context 'when only board columns have number repetition' do
        it 'is invalid' do
          board = board_double(
            rows: valid_number_rows,
            columns: invalid_number_rows,
            grids: valid_number_rows
          )
          validator = BoardValidator.new(board)

          expect(validator.call).to be_invalid
        end
      end

      context 'when only board grids have number repetition' do
        it 'is invalid' do
          board = board_double(
            rows: valid_number_rows,
            columns: valid_number_rows,
            grids: invalid_number_rows
          )
          validator = BoardValidator.new(board)

          expect(validator.call).to be_invalid
        end
      end
    end

    def board_double(rows:, columns:, grids:)
      double('board').tap do |board|
        allow(board).to receive(:rows).and_return(rows)
        allow(board).to receive(:columns).and_return(columns)
        allow(board).to receive(:grids).and_return(grids)
      end
    end

    def valid_number_rows
      Board::SIZE.times.map { |n| (1..Board::SIZE).to_a }
    end

    def invalid_number_rows
      modify_valid_number_rows(
        (0...Board::SIZE).to_a.sample,
        (2...Board::SIZE).to_a.sample,
        with: 1
      )
    end

    def valid_incomplete_number_rows
      modify_valid_number_rows(
        (0...Board::SIZE).to_a.sample,
        (1...Board::SIZE).to_a.sample,
        with: 0
      )
    end

    def modify_valid_number_rows(row_index, col_index, with:)
      valid_number_rows.tap do |rows|
        rows[row_index][col_index] = with
      end
    end
  end
end
