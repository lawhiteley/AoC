defmodule Day001Test do
  use ExUnit.Case

  @data TestHelper.file_to_ints("./test/data/001.txt")
  @example TestHelper.file_to_ints("./test/data/001-example.txt")

  test "day 1 example" do
    assert Day001.most_calories(@example) == 24000
  end

  test "day 1 puzzle 1" do
    assert Day001.most_calories(@data) == 75501
  end

  test "day 1 puzzle 2" do
    assert Day001.total_of_top_n_by_calories(@data, 3) == 215594
  end
end
