defmodule Day001 do

  def calculate_level(directions) do
    convert_parentheses(directions) |> Enum.sum()
  end

  def first_basement_entry(directions) do
    convert_parentheses(directions)
    |> Enum.reduce_while({0, 0}, fn direction, acc ->
      {index, floor} = acc
      if floor == -1 do {:halt, index} else {:cont, {index + 1, floor + direction }} end
    end)
  end

  defp convert_parentheses(directions) do  String.graphemes(directions) |> Enum.map(fn "(" -> 1; ")" -> -1 end) end
end
