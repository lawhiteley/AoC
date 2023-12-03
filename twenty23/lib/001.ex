defmodule Day001 do

  def calibrate(values) do
    values
    |> Enum.map(&String.graphemes(String.replace(&1, ~r/[^\d]/, "")))
    |> Enum.map(&combine/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp combine([head | _ = []]) do head <> head end
  defp combine([head | tail]) do
    head <> List.last(tail)
  end

  def translate_and_calibrate(values) do
    translated = values |> Enum.map(&translate/1) |> Enum.map(&translate/1) # ಠ_ಠ
    calibrate(translated)
  end

  defp translate(values) do
    String.replace(values, [
      "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
    ], fn # I am not proud of this.
      "one" -> "1e"
      "two" -> "2o"
      "three" -> "3e"
      "four" -> "4"
      "five" -> "5e"
      "six" -> "6"
      "seven" -> "7"
      "eight" -> "8t"
      "nine" -> "9e"
    end)
  end
end
