defmodule Day010Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/010.txt")
  @example1 TestHelper.file_to_strings("./test/data/010-example-1.txt")
  @example2 TestHelper.file_to_strings("./test/data/010-example-2.txt")
  @example3 TestHelper.file_to_strings("./test/data/010-example-3.txt")
  @example4 TestHelper.file_to_strings("./test/data/010-example-4.txt")

  test "day 10 example 1" do
    assert Day010.farthest_point(@example1) == 4
  end

  test "day 10 example 2" do
    assert Day010.farthest_point(@example2) == 8
  end

  test "day 10 puzzle 1" do
    assert Day010.farthest_point(@data) == 6812
  end

  test "day 10 example 3" do
    assert Day010.points_inside_loop(@example3) == 4
  end

  test "day 10 example 4" do
    assert Day010.points_inside_loop(@example4) == 10
  end

  test "day 10 puzzle 2" do
    assert Day010.points_inside_loop(@data) == 527
  end
end
