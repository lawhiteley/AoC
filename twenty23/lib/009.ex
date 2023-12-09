defmodule Day009 do

  def predicted_values(values, part \\ :one) do
    Enum.map(values, &String.split(&1, " "))
    |> Enum.map(&predict_next_value(&1, part))
    |> Enum.sum()
  end

  defp predict_next_value(history, part) do
    history = Enum.map(history, &String.to_integer/1)
    deltas = Enum.reverse(to_deltas(history))
    extrapolate(deltas ++ [history], part)
  end

  defp to_deltas(values) do
    deltas = values |> Enum.chunk_every(2, 1, :discard) |> Enum.map(fn [x, y] -> y - x end)

    if Enum.all?(deltas, &(&1 == 0)) do [deltas] else [deltas] ++ to_deltas(deltas) end
  end

  defp extrapolate(deltas, part) do
    Enum.reduce(deltas, 0, fn deltas, acc ->
      if part == :one do acc + hd(Enum.reverse(deltas)) else hd(deltas) - acc end
    end)
  end
end
