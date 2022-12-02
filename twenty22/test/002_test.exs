defmodule Day002Test do
  use ExUnit.Case

  @data TestHelper.file_to_strings("./test/data/002.txt")
  @example TestHelper.file_to_strings("./test/data/002-example.txt")

  test "day 2 example" do
    assert Day002.calculate_score(@example) == 15
  end

  test "day 2 puzzle 1" do
    assert Day002.calculate_score(@data) == 10404
  end

  test "day 2 puzzle 2" do
    assert Day002.part_two(@data) == 15
  end
end
