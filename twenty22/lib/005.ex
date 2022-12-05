defmodule Day005 do

  def top_crates(manifest, crane_mode \\ :reverse) do
    process_manifest(manifest, crane_mode)
    |> Enum.map(fn {_, stack} -> List.first(stack) end)
    |> Enum.join()
  end

  defp process_manifest(manifest, crane_mode) do
    [diagram, instructions] = manifest |> Enum.chunk_by(&(&1 !== "")) |> Enum.reject(&(&1 == [""]))
    {columns, stacks} = List.pop_at(diagram, length(diagram) - 1)

    Enum.reduce(instructions |> Enum.map(&parse_instruction/1), parse_stacks(columns, stacks), fn i, acc ->
      [amount, from, to] = i
      Map.merge(acc, %{
        from => Enum.slice(acc[from], amount, length(acc[from])),
        to => case crane_mode do
          :reverse -> Enum.reverse(Enum.take(acc[from], amount)) ++ acc[to]
          _ -> Enum.take(acc[from], amount) ++ acc[to]
        end
        })
    end)
  end

  defp parse_stacks(columns, stacks) do
    Enum.reduce(String.split(columns), %{}, fn c, acc ->
      column = String.to_integer(c)

      Map.put(acc, column, Enum.map(stacks, fn row ->
         String.at(row, column + (column - 1) * 3) end) |> Enum.reject(&(&1 == " " or &1 == nil))
      )
    end)
  end

  defp parse_instruction(instruction) do
    Regex.run(~r/move (\d+) from (\d+) to (\d+)/, instruction, capture: :all_but_first)
    |> Enum.map(&String.to_integer/1)
  end
end
