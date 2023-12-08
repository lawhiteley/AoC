defmodule Day008 do
  require Math

  def navigate_network(instructions, part \\ :one) do
    [directions | nodes] = instructions |> String.split(["\n\n", "\n"])
    map = build_node_map(nodes)
    starts = if part == :one do ["AAA"] else Map.keys(map) |> Enum.filter(&String.ends_with?(&1, "A")) end
    arrived? = if part == :one do &(&1 == "ZZZ") else &(String.ends_with?(&1, "Z")) end

    Enum.map(starts, &traverse(&1, arrived?, directions, map))
    |> Enum.reduce(fn steps, acc -> Math.lcm(acc, steps) end)
  end

  defp traverse(start, arrived?, directions, map) do
    Enum.reduce_while(Stream.cycle(String.graphemes(directions)), {start, 1}, fn step, acc ->
      {location, steps} = acc
      next_location = next_node(Map.get(map, location), step)
      if arrived?.(next_location) do {:halt, steps} else {:cont, {next_location, steps + 1}} end
    end)
  end

  defp next_node(node, direction) when direction == "R" do node.right end
  defp next_node(node, direction) when direction == "L" do node.left end

  defp build_node_map(nodes) do
    nodes
    |> Enum.map(&String.split(&1, " = ", trim: true))
    |> Enum.reduce(%{}, fn [node, neighbours], acc ->
      [_, left, right] = Regex.run(~r/\((\w+), (\w+)\)/, neighbours)
      Map.put(acc, node, %{left: left, right: right})
    end)
  end
end
