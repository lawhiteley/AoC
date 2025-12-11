defmodule Day010 do
  def fewest_presses(schematics) do
    Enum.map(schematics, fn schematic ->
      [diagram | buttons] = String.split(schematic, " ", trim: true)
      buttons = Enum.slice(buttons, 0, length(buttons) - 1)

      lights =
        String.slice(diagram, 1, String.length(diagram) - 1)
        |> String.graphemes()
        |> Enum.map(&(&1 == "#"))

      powerset(buttons)
      |> Stream.flat_map(fn combination ->
        if valid_combination?(combination, lights), do: [length(combination)], else: []
      end)
      |> Enum.min(fn -> 0 end)
    end)
    |> Enum.sum()
  end

  defp valid_combination?(combination, lights) do
    initial_state = List.duplicate(false, length(lights))

    combination
    |> Enum.flat_map(&get_button/1)
    |> Enum.reduce(initial_state, fn pos, state ->
      List.update_at(state, pos, &(!&1))
    end)
    |> then(&(&1 == lights))
  end

  defp get_button("(" <> rest) do
    String.trim_trailing(rest, ")") |> String.split(",") |> Enum.map(&String.to_integer/1)
  end

  def powerset(enumerable) when is_list(enumerable), do: generate(enumerable)
  def powerset(enumerable), do: generate(Enum.to_list(enumerable))

  defp generate([]), do: []

  defp generate([x | xs]) do
    combinations = generate(xs)
    [[x] | Enum.reduce(combinations, combinations, &[[x | &1] | &2])]
  end
end
