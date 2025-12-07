defmodule Day007Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/007.txt", :full)
  @example TestHelper.file_to_strings("./test/data/007-example.txt", :full)

  test "day 7 example" do
    assert Day007.count_splits(@example) == 21
  end

  test "day 7 puzzle 1" do
    assert Day007.count_splits(@data) == 1711
  end

  test "day 7 puzzle 2" do
    assert Day007.count_timelines(@data) == 36_706_966_158_365
  end
end
