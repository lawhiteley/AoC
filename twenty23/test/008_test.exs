defmodule Day008Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/008.txt")
  @example1 TestHelper.file_to_string("./test/data/008-example-1.txt")
  @example2 TestHelper.file_to_string("./test/data/008-example-2.txt")
  @example3 TestHelper.file_to_string("./test/data/008-example-3.txt")

  test "day 8 example 1" do
    assert Day008.navigate_network(@example1) == 2
  end

  test "day 8 puzzle 1" do
    assert Day008.navigate_network(@data) == 20_569
  end

  test "day 8 example 2" do
    assert Day008.navigate_network(@example2) == 6
  end

  test "day 8 example 3" do
    assert Day008.navigate_network(@example3, :two) == 6
  end

  test "day 8 puzzle 2" do
    assert Day008.navigate_network(@data, :two) == 21_366_921_060_721
  end
end
