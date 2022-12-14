defmodule Day003Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/003.txt")
  @example TestHelper.file_to_strings("./test/data/003-example.txt")

  test "day 3 example" do
    assert Day003.in_both_compartments_score(@example) == 157
  end

  test "day 3 puzzle 1" do
    assert Day003.in_both_compartments_score(@data) == 7824
  end

  test "day 3 puzzle 2" do
    assert Day003.score_of_badges(@data) == 2798
  end
end
