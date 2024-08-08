class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, "   ") }

    @count = 1
    @grid.each do |rows|
      rows.each_index do |index|
        rows[index] = " #{@count} "
        @count += 1
      end
    end
  end

  def display
    col = "|"
    row = "---+---+---"

    @grid.each_with_index do |line, index|
      puts line.join(col)
      puts row unless index == @grid.size - 1
    end
  end

  def update(position, marker)
    row, col = position_with_indicies(position)
    @grid[row][col] = marker if valid_move?(row, col)
  end

  def valid_move?(row, col)
    @grid[row][col] == "   "
  end

  def full?
    nums_arr = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
    grid = @grid.flatten

    return false if grid.intersect?(nums_arr)

    true
  end

  def winner?(marker)
    rows.any? { |row| row.all?(marker) } ||
      columns.any? { |col| col.all?(marker) } ||
      diagonals.any? { |diag| diag.all?(marker) }
  end

  private

  def rows
    @grid
  end

  def columns
    @grid.transpose
  end

  def diagonals
    [
      [[0, 0], [1, 1], [2, 2]],
      [[0, 2], [1, 1], [2, 0]]
    ]
  end

  protected

  def position_with_indicies(position)
    {
      "1" => [0, 0], "2" => [0, 1], "3" => [0, 2],
      "4" => [1, 0], "5" => [1, 1], "6" => [1, 2],
      "7" => [2, 0], "8" => [2, 1], "9" => [2, 2]
    }[position]
  end
end
