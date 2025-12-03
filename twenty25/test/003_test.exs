defmodule Day003Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/003.txt")
  @example TestHelper.file_to_strings("./test/data/003-example.txt")

  test "day 3 example" do
    assert Day003.maximum_joltage_from_two(@example) == 357
  end

  test "day 3 puzzle 1" do
    assert Day003.maximum_joltage_from_two(@data) == 17_301
  end

  test "day 3 puzzle 2" do
    assert Day003.maximum_joltage_from_twelve(@data) == 172_162_399_742_349
  end
end
