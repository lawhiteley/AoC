defmodule Day005 do

  @map_names [
    "seed-to-soil", "soil-to-fertilizer", "fertilizer-to-water",
    "water-to-light", "light-to-temperature", "temperature-to-humidity", "humidity-to-location"
  ]

  def lowest_seed(almanac) do
    {seed_list, map_list} = List.pop_at(String.split(almanac, "\n\n"), 0)
    {seeds, maps} = build_map(seed_list, map_list)

    parse_seeds(seeds)
    |> Enum.map(&traverse_maps_for_seed(maps, &1)) |> Enum.min()
  end

  def lowest_seed_in_range(almanac) do
    {seed_list, map_list} = List.pop_at(String.split(almanac, "\n\n"), 0)
    {seeds, maps} = build_map(seed_list, map_list)
    seed_ranges = parse_seeds(seeds) |> Enum.chunk_every(2) |> Enum.map(fn [start, len] -> (start..(start + len - 1)) end)

    Task.async_stream(seed_ranges, fn range ->
      Enum.reduce(range, fn seed, acc -> lowest_seed(maps, seed, acc) end)
    end, timeout: :infinity) |> Stream.map(fn {_, val} -> val end) |> Enum.to_list() |> Enum.min()
  end

  defp parse_seeds(seeds) do
    seeds |> String.split([":", " "], trim: true) |> tl() |> Enum.map(&String.to_integer/1)
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

  defp lowest_seed(maps, seed, current) do
    location = traverse_maps_for_seed(maps, seed)
    if location < current do location else current end
  end
end
