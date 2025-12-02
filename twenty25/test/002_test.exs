defmodule Day002Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/002.txt")
  @example TestHelper.file_to_string("./test/data/002-example.txt")

  test "day 1 example" do
    assert Day002.sum_invalid_ids(@example) == 1_227_775_554
  end

  test "day 1 puzzle 1" do
    assert Day002.sum_invalid_ids(@data) == 24_747_430_309
  end

  # test "day 1 puzzle 2" do
  #   assert Day002.sum_invalid_ids(@data) == 6496
  # end
end
