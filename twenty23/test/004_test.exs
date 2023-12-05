defmodule Day004Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/004.txt")
  @example1 TestHelper.file_to_strings("./test/data/004-example-1.txt")

  test "day 4 example 1" do
    assert Day004.score_cards(@example1) == 13.0
  end

  test "day 4 puzzle 1" do
    assert Day004.score_cards(@data) == 21_919
  end

  test "day 4 puzzle 2" do
    assert Day004.how_many_cards(@data) == 9_881_048
  end
end
