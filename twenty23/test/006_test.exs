defmodule Day006Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/006.txt")
  @example1 TestHelper.file_to_string("./test/data/006-example-1.txt")

  test "day 6 example 1" do
    assert Day006.winning_strategies(@example1) == 288
  end

  test "day 6 puzzle 1" do
    assert Day006.winning_strategies(@data) == 316_800
  end

  test "day 6 puzzle 2" do
    assert Day006.long_race_winning_strategies(@data) == 45_647_654
  end
end
