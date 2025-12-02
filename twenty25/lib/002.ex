defmodule Day002 do

  def id_repeats_once(ranges) do
    ranges = String.split(ranges, ",") |> Enum.map(&(String.split(&1, "-"))) |> Enum.map(fn [first, last] -> Enum.to_list(String.to_integer(first)..String.to_integer(last)) end)
    ranges |> Enum.flat_map(fn range ->
      range
      |> Enum.filter(fn id -> Integer.digits(id) > 1 and rem(length(Integer.digits(id)), 2) == 0 end)
    end) |> Enum.uniq() |> Enum.filter(fn id ->
      string = Integer.to_string(id)
      {first, second} = String.split_at(string, div(String.length(string), 2))
      first == second
    end) |> Enum.sum()
  end

    def id_repeats_at_least_twice(ranges) do
    ranges = String.split(ranges, ",") |> Enum.map(&(String.split(&1, "-"))) |> Enum.map(fn [first, last] -> Enum.to_list(String.to_integer(first)..String.to_integer(last)) end)
    ranges |> List.flatten() |> Enum.filter(fn id -> String.match?(Integer.to_string(id), ~r/^(.+?)\1+$/) end) |> Enum.sum()
  end
end
