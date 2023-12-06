defmodule Day005 do
  require Logger

  @map_names [
    "seed-to-soil", "soil-to-fertilizer", "fertilizer-to-water",
    "water-to-light", "light-to-temperature", "temperature-to-humidity", "humidity-to-location"
  ]

  def lowest_seed(almanac) do
    {s, m} = List.pop_at(String.split(almanac, "\n\n"), 0)
    {seeds, maps} = build_map(s, m) # TODO: rename and sort
    seeds |> String.split([":", " "], trim: true) |> tl() |> Enum.map(&String.to_integer/1) # TODO: repeated below, little util fun
    |> Enum.map(&traverse_maps_for_seed(maps, &1)) |> Enum.min()
  end

  def lowest_seed_in_range(almanac) do
    {s, m} = List.pop_at(String.split(almanac, "\n\n"), 0)
    {seeds, maps} = build_map(s, m) # TODO: rename and sort
    seed_ranges = s |> String.split([":", " "], trim: true) |> tl()
    |> Enum.map(&String.to_integer/1) |> Enum.chunk_every(2) |> Enum.map(fn [start, len] -> (start..(start + len - 1)) end) # TODO: range generation could be extracted also

    Enum.map(seed_ranges, fn range -> Enum.map(range, &traverse_maps_for_seed(maps, &1)) end) |> List.flatten() |> Enum.min()
  end

  defp build_map(seeds, maps) do
    {seeds, maps |> Enum.reduce(%{}, fn line, acc ->
      generate_ranges(line, acc)
    end)}
  end

  defp generate_ranges(line, map) do
    [name, values] = String.split(line, ":", trim: true)
    range = String.split(values, "\n", trim: true) |> Enum.reduce(%{}, fn values, acc ->
      [dest, src, len] = String.split(values, " ", trim: true) |> Enum.map(&String.to_integer/1)
      Map.put(acc, src..(src + len - 1), dest)
    end)
    Map.update(map, name, range, fn existing_ranges -> Map.merge(existing_ranges, range) end)
  end

  defp traverse_maps_for_seed(maps, seed) do
    Enum.reduce(@map_names, seed, fn map, acc ->
      map = Map.get(maps, map <> " map")
      key = map |> Map.keys() |> Enum.filter(fn r -> acc in r end)
      if key == [] do acc else
        range = key |> hd
       (acc - range.first) + Map.get(map, range)
      end
    end)
  end
end
