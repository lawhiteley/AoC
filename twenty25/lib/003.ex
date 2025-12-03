defmodule Day003 do
  def maximum_joltage_from_two(banks) do
    banks
    |> Enum.map(&find_best_two(String.split(&1, "", trim: true)))
    |> Enum.sum()
  end

  defp find_best_two(cells) do
    indexed = Enum.with_index(cells)

    for {a, i} <- indexed, {b, j} <- indexed, i < j do
      String.to_integer(a <> b)
    end
    |> Enum.max()
  end

  def maximum_joltage_from_twelve(banks) do
    banks
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(fn bank ->
      find_best_twelve(bank |> Enum.map(&String.to_integer/1))
    end)
    |> Enum.sum()
  end

  def find_best_twelve(cells) do
    cells
    |> Enum.with_index()
    |> Enum.chunk_every(length(cells) - 11, 1, :discard)
    |> Enum.reduce({[], -1}, fn window, {acc, used} ->
      {highest_val, highest_idx} = find_next_highest(window, used)

      {acc ++ [highest_val], highest_idx}
    end)
    |> elem(0)
    |> Enum.join()
    |> String.to_integer()
  end

  defp find_next_highest(window, used) do
    case Enum.reject(window, fn {_, i} -> used >= i end) do
      [] -> {nil, used}
      list -> Enum.max_by(list, fn {v, _} -> v end)
    end
  end
end
