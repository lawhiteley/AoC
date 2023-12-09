defmodule Day009Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/009.txt")
  @example1 TestHelper.file_to_strings("./test/data/009-example-1.txt")

  test "day 9 example 1" do
    assert Day009.predicted_values(@example1) == 114
  end

  test "day 9 puzzle 1" do
    assert Day009.predicted_values(@data) == 2_174_807_968
  end

  test "day 9 puzzle 2" do
    assert Day009.predicted_values(@data, :two) == 1208
  end
end
