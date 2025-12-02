defmodule Day002 do
  def id_repeats_once(ranges) do
    to_range_list(ranges)
    |> Enum.filter(fn id ->
      string = Integer.to_string(id)
      {first, second} = String.split_at(string, div(String.length(string), 2))
      first == second
    end) |> Enum.sum()
  end

  def id_repeats_at_least_twice(ranges) do
    to_range_list(ranges)
    |> Enum.filter(fn id -> String.match?(Integer.to_string(id), ~r/^(.+?)\1+$/) end)
    |> Enum.sum()
  end

  defp to_range_list(string) do
    String.split(string, ",")
    |> Enum.flat_map(fn range ->
      [first, last] = String.split(range, "-")
      String.to_integer(first)..String.to_integer(last)
    end) |> Enum.to_list()
  end
end
