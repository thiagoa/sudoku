$LOAD_PATH << File.expand_path('../lib')

require 'sudoku/board_parser'

module Sudoku
  RSpec.describe 'validation integration tests' do
    context 'when the sudoku is valid' do
      context 'and it is complete' do
        it 'returns valid' do
          file = fixture('valid_complete.sudoku')

          board = BoardParser.new(file).call

          expect(board.validate).to be_valid
        end
      end

      context 'and it is incomplete' do
        it 'returns incomplete' do
          file = fixture('valid_incomplete.sudoku')

          board = BoardParser.new(file).call

          expect(board.validate).to be_incomplete
        end
      end
    end

    context 'when the sudoku is invalid' do
      invalid_fixtures = %w(
        invalid_due_to_row_dupe.sudoku
        invalid_due_to_column_dupe.sudoku
        invalid_due_to_subgroup_dupe.sudoku
      )

      invalid_fixtures.each do |filepath|
        it 'returns invalid' do
          file = fixture(filepath)

          board = BoardParser.new(file).call

          expect(board.validate).to be_invalid
        end
      end
    end

    def fixture(filepath)
      File.open(File.expand_path("../../fixtures/#{filepath}", __FILE__))
    end
  end
end
