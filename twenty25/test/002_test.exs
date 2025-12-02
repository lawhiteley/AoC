defmodule Day002Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/002.txt")
  @example TestHelper.file_to_string("./test/data/002-example.txt")

  test "day 2 example" do
    assert Day002.id_repeats_once(@example) == 1_227_775_554
  end

  test "day 2 puzzle 1" do
    assert Day002.id_repeats_once(@data) == 24_747_430_309
  end

  test "day 2 puzzle 2" do
    assert Day002.id_repeats_at_least_twice(@data) == 30_962_646_823
  end
end
