defmodule Day012Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/012.txt")
  @example TestHelper.file_to_string("./test/data/012-example.txt")

  @tag :skip
  test "day 12 example 1" do
    assert Day012.count_sufficient_regions(@example) == 2
  end

  test "day 12 puzzle 1" do
    assert Day012.count_sufficient_regions(@data) == 531
  end
end
