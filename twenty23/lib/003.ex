defmodule Day003 do

  def find_parts(schematic) do
    rows = 0..length(schematic) |> Stream.zip(schematic) |> Enum.into(%{})
    neighbourhood = rows |> Enum.map(&generate_neighbourhood/1)
    generate_adjacency_map(neighbourhood, rows, %{}) |> Map.values() |> List.flatten() |> Enum.sum()
  end

  def find_gear_ratios(schematic) do
    rows = 0..length(schematic) |> Stream.zip(schematic) |> Enum.into(%{})
    neighbourhood = rows |> Enum.map(&generate_neighbourhood/1)
    generate_adjacency_map(neighbourhood, rows, %{})
    |> Enum.map(fn {_, adjacent_to} -> if length(adjacent_to) == 2 do Enum.product(adjacent_to) else 0 end end) |> Enum.sum()
  end

  defp generate_adjacency_map(neighbourhood, rows, matches) do
    neighbourhood
    |> Enum.map(&search(&1, rows, matches))
    |> List.flatten() |> Enum.reduce(&Map.merge(&1, &2, fn _, v1, v2 -> v1 ++ v2 end))
  end

  defp generate_neighbourhood({index, row}) do
    Regex.scan(~r/\d+/, row, return: :index)
    |> Enum.map(fn [{start, length}] ->
      part_number = String.slice(row, start, length)
      {index, part_number, (start - 1)..(start + length) |> Enum.filter(fn column -> column >= 0 and column <= String.length(row) end)}
    end)
  end

  defp search(searches, rows, matches) do
    searches
    |> Enum.map(fn {index, part_number, range} ->
       Enum.to_list((index - 1)..(index + 1)) |> Enum.map(fn i ->
        part_number = String.to_integer(part_number)
        find_adjacent(Map.get(rows, i), Range.new(List.first(range), List.last(range)))
        |> Enum.map(&Map.update(matches, {i, &1}, [part_number], fn results -> results ++ part_number end))
      end)
    end)
  end

  defp find_adjacent(nil, _) do [] end
  defp find_adjacent(row, adjacent) do
    Regex.scan(~r/[^\d\.]/, row, return: :index) |> Enum.map(fn [{column, _}] -> column end) |> Enum.filter(fn column -> column in adjacent end)
  end
end
