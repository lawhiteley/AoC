defmodule Day003Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/003.txt")
  @example1 TestHelper.file_to_strings("./test/data/003-example-1.txt")

  test "day 3 example 1" do
    assert Day003.find_parts(@example1) == 4361
  end

  test "day 3 puzzle 1" do
    assert Day003.find_parts(@data) == 531_561
  end

  test "day 3 puzzle 2" do
    assert Day003.find_gear_ratios(@data) == 83_279_367
  end
end
