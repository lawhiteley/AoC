defmodule Day005 do
  def count_spoiled(ingredients) do
    [ranges, ingredients] =
      ingredients
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, "\n"))

    ranges = Enum.map(ranges, &string_to_range/1)

    Enum.count(ingredients, fn ingredient ->
      Enum.any?(ranges, &(String.to_integer(ingredient) in &1))
    end)
  end

  def count_fresh(ingredients) do
    [ranges, _] =
      String.split(ingredients, "\n\n") |> Enum.map(&String.replace(&1, "\n", ","))

    ranges = String.split(ranges, ",") |> Enum.map(&string_to_range/1)

    remove_overlaps(ranges) |> Enum.map(&Range.size(&1)) |> Enum.sum()
  end

  defp remove_overlaps(ranges) do
    ranges
    |> Enum.sort_by(fn start.._//_ -> start end)
    |> Enum.reduce([], fn current, acc ->
      case acc do
        [] ->
          [current]

        [last | rest] ->
          beginning_of_first..end_of_first//_ = last
          _..end_of_second//_ = current

          cond do
            Range.disjoint?(last, current) -> [current | acc]
            end_of_second <= end_of_first -> acc
            true -> [beginning_of_first..max(end_of_first, end_of_second) | rest]
          end
      end
    end)
  end

  defp string_to_range(string) do
    [first, last] = String.split(string, "-")
    String.to_integer(first)..String.to_integer(last)
  end
end
