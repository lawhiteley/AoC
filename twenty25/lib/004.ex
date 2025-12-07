defmodule Day004 do
  def count_of_accessible_rolls(grid, width \\ 10) do
    grid = String.replace(grid, "\n", "") |> String.split("", trim: true) |> Enum.with_index()

    get_adjacent(grid, width)
    |> Enum.count(fn {_, search_result} ->
      length(search_result) < 4
    end)
  end

  def count_possible_removals(grid, width \\ 10) do
    initial_grid =
      String.replace(grid, "\n", "") |> String.split("", trim: true) |> Enum.with_index()

    traverse_removals(initial_grid, width)
  end

  defp traverse_removals(grid, width, acc \\ 0) do
    to_replace =
      get_adjacent(grid, width)
      |> Enum.filter(fn {_, result} ->
        length(result) < 4
      end)
      |> Enum.map(&elem(&1, 0))

    case to_replace do
      [] ->
        acc

      _ ->
        new_grid =
          grid
          |> Enum.map(fn {current, location} ->
            if location in to_replace, do: "X", else: current
          end)
          |> Enum.with_index()

        traverse_removals(new_grid, width, acc + length(to_replace))
    end
  end

  defp get_adjacent(grid, width) do
    grid
    |> Enum.filter(fn {char, _} -> char == "@" end)
    |> Enum.map(fn {_, location} ->
      adjacent =
        Enum.filter(calculate_adjacent_locations(location, width), fn search_location ->
          {result, _} = Enum.at(grid, search_location, {"", -1})
          result == "@"
        end)

      {location, adjacent}
    end)
  end

  def calculate_adjacent_locations(location, width) do
    [
      location - width - 1,
      location - width,
      location - width + 1,
      location - 1,
      location + 1,
      location + width - 1,
      location + width,
      location + width + 1
    ]
    |> Enum.filter(&(abs(rem(&1, width) - rem(location, width)) <= 1 and &1 > 0))
  end
end
