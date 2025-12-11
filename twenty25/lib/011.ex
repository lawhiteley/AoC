defmodule Day011 do
  def all_paths(routes) do
    traverse(create_map(routes), "you") |> elem(0)
  end

  def paths_through_devices(routes) do
    traverse(create_map(routes), "svr", ["dac", "fft"]) |> elem(0)
  end

  defp create_map(routes) do
    Enum.reduce(routes, %{}, fn route, acc ->
      [location, attached_to] = String.split(route, ":", trim: true)
      Map.put(acc, location, String.split(attached_to, " ", trim: true))
    end)
  end

  defp traverse(map, current, left_to_visit \\ [], cache \\ %{})
  defp traverse(_, "out", [], cache), do: {1, cache}

  defp traverse(map, current, left_to_visit, cache) do
    cache_key = {current, left_to_visit}

    case Map.get(cache, cache_key) do
      nil ->
        adjacent = Map.get(map, current, [])

        left_to_visit =
          if current in left_to_visit do
            List.delete(left_to_visit, current)
          else
            left_to_visit
          end

        {result, cache} =
          Enum.reduce(adjacent, {0, cache}, fn neighbour, {acc, acc_cache} ->
            {paths, updated_cache} = traverse(map, neighbour, left_to_visit, acc_cache)
            {acc + paths, updated_cache}
          end)

        {result, Map.put(cache, cache_key, result)}

      result ->
        {result, cache}
    end
  end
end
