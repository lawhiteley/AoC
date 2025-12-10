defmodule Day009Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/009.txt")
  @example TestHelper.file_to_strings("./test/data/009-example.txt")

  test "day 9 example 1" do
    assert Day009.largest_rectangle(@example) == 50
  end

  test "day 9 puzzle 1" do
    assert Day009.largest_rectangle(@data) == 4_746_238_001
  end

  test "day 9 example 2" do
    assert Day009.largest_red_and_green_rectangle(@example) == 24
  end

  test "day 9 puzzle 2" do
    assert Day009.largest_red_and_green_rectangle(@data) == 1_552_139_370
  end
end
