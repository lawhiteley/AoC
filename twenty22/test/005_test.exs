defmodule Day005Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/005.txt", :trailing)
  @example TestHelper.file_to_strings("./test/data/005-example.txt", :trailing)

  test "day 5 example" do
    assert Day005.top_crates(@example) == "CMZ"
  end

  test "day 5 puzzle 1" do
    assert Day005.top_crates(@data) == "FJSRQCFTN"
  end

  test "day 5 puzzle 2" do
    assert Day005.top_crates(@data, :standard) == "CJVLJQPHS"
  end
end
