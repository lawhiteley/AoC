defmodule Day006 do

  def winning_strategies(races) do
    parse_races(races)
    |> Enum.map(fn [_ | values] -> values |> Enum.map(&String.to_integer/1) end)
    |> Enum.zip() |> Enum.map(&viable_strategy_count/1) |> Enum.product()
  end

  def long_race_winning_strategies(races) do
    [time, distance] = parse_races(races)
    |> Enum.map(fn [_ | values] -> values |> Enum.join() |> String.to_integer() end)
    viable_strategy_count({time, distance})
  end

  defp viable_strategy_count({time, distance}) do
    root = :math.sqrt((:math.pow(time, 2) - 4 * distance))
    max = (time + root) / 2
    min = (time - root) / 2
    trunc(:math.ceil(max) - :math.floor(min) - 1)
  end

  defp parse_races(races) do races |> String.split("\n") |> Enum.map(&String.split(&1, [":", " "], trim: true)) end
end
