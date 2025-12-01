defmodule Day001Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/001.txt")
  @example TestHelper.file_to_strings("./test/data/001-example.txt")

  test "day 1 example" do
    assert Day001.count_zero_visits(@example) == 3
  end

  test "day 1 puzzle 1" do
    assert Day001.count_zero_visits(@data) == 1165
  end

  test "day 1 puzzle 2" do
    assert Day001.count_of_clicks(@data) == 6496
  end
end
