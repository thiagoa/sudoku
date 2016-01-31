require 'sudoku/grid_extractor'
require 'sudoku/board_error'

module Sudoku
  RSpec.describe GridExtractor do
    BOARD_ROWS = [
      [1, 1, 1, 2, 2, 2, 3, 3, 3],
      [4, 4, 4, 2, 2, 2, 5, 5, 5],
      [3, 3, 3, 4, 4, 4, 4, 5, 4],
      [4, 4, 4, 6, 6, 6, 5, 5, 5],
      [5, 5, 5, 6, 6, 6, 7, 7, 7],
      [6, 6, 6, 7, 7, 7, 8, 8, 8],
      [7, 7, 7, 9, 9, 9, 8, 8, 8],
      [8, 8, 8, 0, 0, 0, 9, 9, 9],
      [9, 9, 9, 0, 0, 0, 0, 0, 0]
    ]

    describe '#call' do
      it 'does not extract a negative grid' do
        expect { build_grid_extractor.call(-1) }.to raise_error(BoardError)
      end

      it 'extracts the first grid' do
        expect(build_grid_extractor.call(0)).to eq(
          [1, 1, 1, 4, 4, 4, 3, 3, 3]
        )
      end

      it 'extracts the second grid' do
        expect(build_grid_extractor.call(1)).to eq(
          [2, 2, 2, 2, 2, 2, 4, 4, 4]
        )
      end

      it 'extracts the third grid' do
        expect(build_grid_extractor.call(2)).to eq(
          [3, 3, 3, 5, 5, 5, 4, 5, 4]
        )
      end

      it 'extracts the fourth grid' do
        expect(build_grid_extractor.call(3)).to eq(
          [4, 4, 4, 5, 5, 5, 6, 6, 6]
        )
      end

      it 'extracts the fifth grid' do
        expect(build_grid_extractor.call(4)).to eq(
          [6, 6, 6, 6, 6, 6, 7, 7, 7]
        )
      end

      it 'extracts the sixth grid' do
        expect(build_grid_extractor.call(5)).to eq(
          [5, 5, 5, 7, 7, 7, 8, 8, 8]
        )
      end

      it 'extracts the seventh grid' do
        expect(build_grid_extractor.call(6)).to eq(
          [7, 7, 7, 8, 8, 8, 9, 9, 9]
        )
      end

      it 'extracts the eight grid' do
        expect(build_grid_extractor.call(7)).to eq(
          [9, 9, 9, 0, 0, 0, 0, 0, 0]
        )
      end

      it 'extracts the ninth grid' do
        expect(build_grid_extractor.call(8)).to eq(
          [8, 8, 8, 9, 9, 9, 0, 0, 0]
        )
      end

      it 'does not extract the tenth grid' do
        expect { build_grid_extractor.call(9) }.to raise_error(BoardError)
      end
    end

    def build_grid_extractor
      GridExtractor.new(board_double)
    end

    def board_double
      double('board').tap do |board|
        allow(board).to receive(:rows).and_return(BOARD_ROWS)
      end
    end
  end
end
