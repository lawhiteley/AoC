defmodule Day003Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/003.txt")
  @example TestHelper.file_to_strings("./test/data/003-example.txt")

  test "day 3 example" do
    assert Day003.maximum_joltage(@example) == 357
  end

  test "day 3 puzzle 1" do
    assert Day003.maximum_joltage(@data) == 24_747_430_309
  end

  # test "day 3 puzzle 2" do
  #   assert Day003.id_repeats_at_least_twice(@data) == 30_962_646_823
  # end
end
