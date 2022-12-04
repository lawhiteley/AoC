defmodule Day004Test do
  use ExUnit.Case

  @data TestHelper.file_to_strings("./test/data/004.txt")
  @example TestHelper.file_to_strings("./test/data/004-example.txt")

  test "day 4 example" do
    assert Day004.overlapping_assignments(@example) == 2
  end

  test "day 4 puzzle 1" do
    assert Day004.overlapping_assignments(@data) == 444
  end

  test "day 4 puzzle 2" do
    assert Day004.intersecting_assignments(@data) == 801
  end
end
