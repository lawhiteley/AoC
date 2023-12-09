defmodule Day001Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/001.txt")
  @example TestHelper.file_to_string("./test/data/001-example-1.txt")

  test "day 1 example" do
    assert Day001.calculate_level(@example) == 3
  end

  test "day 1 puzzle 1" do
    assert Day001.calculate_level(@data) == 232
  end

  test "day 1 puzzle 2" do
    assert Day001.first_basement_entry(@data) == 7000
  end
end
