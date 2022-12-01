defmodule Day001 do

  defp sorted_by_calories(inventory, sort \\ :desc) do
    inventory
    |> Enum.chunk_by(&(&1 !== "")) |> Enum.reject(&(&1 == [""]))
    |> Enum.map(&Enum.sum/1) |> Enum.sort(sort)
  end

  def most_calories(inventory) do
    List.first(sorted_by_calories(inventory))
  end

  def total_of_top_n_by_calories(inventory, n \\ 3) do
    sorted_by_calories(inventory) |> Enum.take(n) |> Enum.sum()
  end
end
