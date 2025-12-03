defmodule Day003 do
  def maximum_joltage(banks) do
    banks
    |> Enum.map(&find_best_two(String.split(&1, "", trim: true)))
    |> Enum.sum()
  end

  defp find_best_two(list) do
    indexed = Enum.with_index(list)

    for {a, i} <- indexed, {b, j} <- indexed, i < j do
      String.to_integer(a <> b)
    end
    |> Enum.max()
  end
end
