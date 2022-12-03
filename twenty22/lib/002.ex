defmodule Day002 do

  # YOLO

  def part_one(rounds) do
    rounds |> Enum.map(fn x ->
      case String.split(x, " ") do
        [ "A", "X" ] -> 1 + 3
        [ "A", "Y" ] -> 2 + 6
        [ "A", "Z" ] -> 3 + 0
        [ "B", "X" ] -> 1 + 0
        [ "B", "Y" ] -> 2 + 3
        [ "B", "Z" ] -> 3 + 6
        [ "C", "X" ] -> 1 + 6
        [ "C", "Y" ] -> 2 + 0
        [ "C", "Z" ] -> 3 + 3
        _ -> raise "u wot m8"
      end
    end) |> Enum.sum()
  end

  def part_two(rounds) do
    rounds |> Enum.map(fn x ->
      case String.split(x, " ") do
        [ "A", "X" ] -> 3 + 0
        [ "A", "Y" ] -> 1 + 3
        [ "A", "Z" ] -> 2 + 6
        [ "B", "X" ] -> 1 + 0
        [ "B", "Y" ] -> 2 + 3
        [ "B", "Z" ] -> 3 + 6
        [ "C", "X" ] -> 2 + 0
        [ "C", "Y" ] -> 3 + 3
        [ "C", "Z" ] -> 1 + 6
        _ -> raise "u wot m8"
      end
    end) |> Enum.sum()
  end
end
