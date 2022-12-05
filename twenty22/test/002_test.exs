defmodule Day002Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/002.txt")
  @example TestHelper.file_to_strings("./test/data/002-example.txt")

  test "day 2 example" do
    assert Day002.part_one(@example) == 15
  end

  test "day 2 puzzle 1" do
    assert Day002.part_one(@data) == 10404
  end

  test "day 2 puzzle 2" do
    assert Day002.part_two(@data) == 10334
  end
end
