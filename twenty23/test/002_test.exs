defmodule Day002Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/002.txt")
  @example1 TestHelper.file_to_strings("./test/data/002-example-1.txt")
  @cube_counts %{red: 12, green: 13, blue: 14}

  test "day 2 example 1" do
    assert Day002.parse_games(@example1, @cube_counts) == 8
  end

  test "day 2 puzzle 1" do
    assert Day002.parse_games(@data, @cube_counts) == 2528
  end

  test "day 2 puzzle 2" do
    assert Day002.sum_powers(@data) == 67_363
  end
end
