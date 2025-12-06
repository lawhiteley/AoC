defmodule Day006Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/006.txt", :full)
  @example TestHelper.file_to_strings("./test/data/006-example.txt", :full)

  test "day 6 example" do
    assert Day006.calculate_vertical(@example) == 4_277_556
  end

  test "day 6 puzzle 1" do
    assert Day006.calculate_vertical(@data) == 4_580_995_422_905
  end

  test "day 6 puzzle 2" do
    assert Day006.calculate_right_to_left(@data) == 10_875_057_285_868
  end
end
