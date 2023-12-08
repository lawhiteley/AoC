defmodule Day007Test do
  use ExUnit.Case, async: true

  @data TestHelper.file_to_strings("./test/data/007.txt")
  @example1 TestHelper.file_to_strings("./test/data/007-example-1.txt")

  test "day 7 example 1" do
    assert Day007.score_bets(@example1) == 6440
  end

  test "day 7 puzzle 1" do
    assert Day007.score_bets(@data) == 249_748_283
  end

  test "day 7 example 2" do
    assert Day007.score_bets(@example1, true) == 5905
  end

  test "day 7 puzzle 2" do
    assert Day007.score_bets(@data, true) == 248_029_057
  end
end
