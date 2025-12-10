defmodule Day010Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/010.txt")
  @example TestHelper.file_to_strings("./test/data/010-example.txt")

  test "day 10 example 1" do
    assert Day010.fewest_presses(@example) == 7
  end

  test "day 10 puzzle 1" do
    assert Day010.fewest_presses(@data) == 444
  end

  # test "day 10 puzzle 2" do
  #   assert Day010.largest_red_and_green_rectangle(@data) == 1_552_1310_370
  # end
end
