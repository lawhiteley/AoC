defmodule Day009 do
  def largest_rectangle(tiles) do
    elem(hd(calculate_areas(tiles)), 2)
  end

  # https://en.wikipedia.org/wiki/Minimum_bounding_box#Axis-aligned_minimum_bounding_box
  def largest_red_and_green_rectangle(tiles) do
    polygon =
      Enum.map(tiles, fn point ->
        String.split(point, ",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
      end)

    polygon_size = length(polygon)

    edges =
      0..(polygon_size - 1)
      |> Enum.map(fn i ->
        c1 = Enum.at(polygon, i)
        c2 = Enum.at(polygon, rem(i - 1 + polygon_size, polygon_size))
        {min_coord(c1, c2), max_coord(c1, c2)}
      end)
      |> Enum.sort_by(fn {c1, c2} -> -get_area(c1, c2) end)

    sizes =
      0..(polygon_size - 2)
      |> Enum.flat_map(fn i ->
        (i + 1)..(polygon_size - 1)
        |> Enum.map(fn j ->
          c1 = Enum.at(polygon, i)
          c2 = Enum.at(polygon, j)
          {get_area(c1, c2), min_coord(c1, c2), max_coord(c1, c2)}
        end)
      end)
      |> Enum.sort_by(fn {area, _, _} -> -area end)

    Enum.find_value(sizes, fn {area, {x1, y1}, {x2, y2}} ->
      {y1, y2} = if y1 > y2, do: {y2, y1}, else: {y1, y2}

      fully_contained? =
        Enum.all?(edges, fn {{x3, y3}, {x4, y4}} ->
          not (x4 > x1 and x3 < x2 and y4 > y1 and y3 < y2)
        end)

      if fully_contained?, do: area
    end)
  end

  defp calculate_areas(tiles) do
    Enum.map(tiles, fn point -> Enum.map(String.split(point, ","), &String.to_integer/1) end)
    |> combinations(2)
    |> Enum.map(fn [[x1, y1], [x2, y2]] ->
      {[x1, y1], [x2, y2], get_area({x1, y1}, {x2, y2})}
    end)
    |> Enum.sort_by(fn {_, _, area} -> area end, :desc)
  end

  # From https://rosettacode.org/wiki/Combinations#Elixir
  defp combinations(_, 0), do: [[]]
  defp combinations([], _), do: []

  defp combinations([h | t], m) do
    for(l <- combinations(t, m - 1), do: [h | l]) ++ combinations(t, m)
  end

  defp get_area({x1, y1}, {x2, y2}) do
    (abs(x1 - x2) + 1) * (abs(y1 - y2) + 1)
  end

  defp min_coord({x1, y1}, {x2, y2}) do
    {min(x1, x2), min(y1, y2)}
  end

  defp max_coord({x1, y1}, {x2, y2}) do
    {max(x1, x2), max(y1, y2)}
  end
end
