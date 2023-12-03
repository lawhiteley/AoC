defmodule Day001Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/001.txt")
  @example1 TestHelper.file_to_strings("./test/data/001-example-1.txt")
  @example2 TestHelper.file_to_strings("./test/data/001-example-2.txt")

  test "day 1 example 1" do
    assert Day001.calibrate(@example1) == 142
  end

  test "day 1 example 2" do
    assert Day001.translate_and_calibrate(@example2) == 281
  end

  test "day 1 puzzle 1" do
    assert Day001.calibrate(@data) == 55_477
  end

  test "day 1 puzzle 2" do
    assert Day001.translate_and_calibrate(@data) == 54_431
  end
end
