defmodule Day002 do

  def sum_invalid_ids(ranges) do
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
end
