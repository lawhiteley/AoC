defmodule Day005Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/005.txt")
  @example TestHelper.file_to_string("./test/data/005-example.txt")

  test "day 5 example" do
    assert Day005.find_spoiled(@example) == 3
  end

  test "day 5 puzzle 1" do
    assert Day005.find_spoiled(@data) == 885
  end

  # test "day 5 puzzle 2" do
  #   assert Day005.count_possible_removals(@data, 140) == 8310
  # end
end
