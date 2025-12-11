defmodule Day011Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/011.txt")
  @example TestHelper.file_to_strings("./test/data/011-example.txt")

  test "day 11 example 1" do
    assert Day011.all_paths(@example) == 5
  end

  test "day 11 puzzle 1" do
    assert Day011.all_paths(@data) == 652
  end

  test "day 11 puzzle 2" do
    assert Day011.paths_through_devices(@data) == 362_956_369_749_210
  end
end
