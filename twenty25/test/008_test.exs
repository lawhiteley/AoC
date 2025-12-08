defmodule Day008Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/008.txt")
  @example TestHelper.file_to_strings("./test/data/008-example.txt")

  test "day 8 example 1" do
    assert Day008.three_largest_circuits(@example) == 40
  end

  test "day 8 puzzle 1" do
    assert Day008.three_largest_circuits(@data, 1000) == 54_600
  end

  test "day 8 example 2" do
    assert Day008.last_two_in_circuit(@example) == 25272
  end

  test "day 8 puzzle 2" do
    assert Day008.last_two_in_circuit(@data) == 107_256_172
  end
end
