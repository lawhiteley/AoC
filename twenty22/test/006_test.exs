defmodule Day006Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/006.txt")
  @example TestHelper.file_to_string("./test/data/006-example.txt")

  test "day 6 example" do
    assert Day006.find_marker(@example) == 5
  end

  test "day 6 puzzle 1" do
    assert Day006.find_marker(@data) == 1912
  end

  test "day 6 puzzle 2" do
    assert Day006.find_marker(@data, 14) == 2122
  end
end
