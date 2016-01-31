module Sudoku
  class BoardValidator
    class Result
      def initialize(result)
        @result = result
      end

      %i(valid invalid incomplete).each do |state|
        define_method "#{state}?" do
          @result == state
        end
      end
    end
  end
end
