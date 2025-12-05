defmodule Day004Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/004.txt")
  @example TestHelper.file_to_string("./test/data/004-example.txt")

  test "day 4 example" do
    assert Day004.count_of_accessible_rolls(@example) == 13
  end

  test "day 4 puzzle 1" do
    assert Day004.count_of_accessible_rolls(@data, 140) == 1457
  end

  @tag timeout: 120_000 # ┌( ͝° ͜ʖ͡°)=ε/̵͇̿̿/’̿’̿
  @tag :skip
  test "day 4 puzzle 2" do
    assert Day004.count_possible_removals(@data, 140) == 8310
  end
end
