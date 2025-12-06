defmodule Day006Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/006.txt")
  @example TestHelper.file_to_strings("./test/data/006-example.txt")

  test "day 6 example" do
    assert Day006.calculate_vertical(@example) == 4_277_556
  end

  test "day 6 puzzle 1" do
    assert Day006.calculate_vertical(@data) == 885
  end

  # test "day 6 puzzle 2" do
  #   assert Day006.count_fresh(@data) == 348_115_621_205_535
  # end
end
