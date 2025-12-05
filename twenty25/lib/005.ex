defmodule Day005 do

  require Logger

  def find_spoiled(ingredients) do
    [ranges, ingredients] =
      String.split(ingredients, "\n\n") |> Enum.map(&String.replace(&1, "\n", ","))

      # don't need two String.split calls
    ranges = String.split(ranges, ",") |> Enum.map(&string_to_range/1)

    String.split(ingredients, ",") |> Enum.filter(fn ingredient ->
      Enum.any?(ranges, &(String.to_integer(ingredient) in &1))
    end) |> length()
  end

  def string_to_range(string) do
    [first, last] = String.split(string, "-")
    String.to_integer(first)..String.to_integer(last)
  end
end
