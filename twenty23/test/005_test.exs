defmodule Day005Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_string("./test/data/005.txt")
  @example1 TestHelper.file_to_string("./test/data/005-example-1.txt")

  test "day 5 example 1" do
    assert Day005.lowest_seed(@example1) == 35
  end

  test "day 5 puzzle 1" do
    assert Day005.lowest_seed(@data) == 600_279_879
  end

  @tag timeout: :infinity # ┌( ͝° ͜ʖ͡°)=ε/̵͇̿̿/’̿’̿
  @tag :skip
  test "day 5 puzzle 2" do
    assert Day005.lowest_seed_in_range(@data) == 20_191_102
  end
end
