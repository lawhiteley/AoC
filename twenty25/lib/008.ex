defmodule Day008 do
  alias Day008.DisjointSet

  def three_largest_circuits(rows, desired_connections \\ 10) do
    combinations(2, parse_xyz(rows))
    |> Enum.map(fn [a, b] -> {[a, b], euclidian_distance(a, b)} end)
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.take(desired_connections)
    |> Enum.reduce(DisjointSet.new(), fn {[a, b], _}, acc -> DisjointSet.union(acc, a, b) end)
    |> DisjointSet.sizes()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def last_two_in_circuit(rows) do
    combinations(2, parse_xyz(rows))
    |> Enum.map(fn [a, b] -> {[a, b], euclidian_distance(a, b)} end)
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.reduce_while(DisjointSet.new(), fn {[a, b], _}, acc ->
      updated = DisjointSet.union(acc, a, b)

      if DisjointSet.sizes(updated) == [length(rows)] do
        {:halt, a.x * b.x}
      else
        {:cont, updated}
      end
    end)
  end

  defp parse_xyz(rows) do
    Enum.map(rows, fn xyz ->
      [x, y, z] = String.split(xyz, ",") |> Enum.map(&String.to_integer/1)
      %{x: x, y: y, z: z}
    end)
  end

  defp euclidian_distance(p1, p2) do
    :math.sqrt(:math.pow(p2.x - p1.x, 2) + :math.pow(p2.y - p1.y, 2) + :math.pow(p2.z - p1.z, 2))
  end

  # From https://rosettacode.org/wiki/Combinations#Elixir
  def combinations(0, _), do: [[]]
  def combinations(_, []), do: []

  def combinations(m, [h | t]) do
    for(l <- combinations(m - 1, t), do: [h | l]) ++ combinations(m, t)
  end

  defmodule DisjointSet do
    defstruct parent: %{}, size: %{}, next_id: 0

    def new(), do: %__MODULE__{}

    def find(%DisjointSet{} = ds, key) do
      case Map.fetch(ds.parent, key) do
        {:ok, parent} ->
          if parent == key do
            {ds, key}
          else
            {ds, root} = find(ds, parent)
            {%{ds | parent: Map.put(ds.parent, key, root)}, root}
          end

        :error ->
          ds = %{ds | parent: Map.put(ds.parent, key, key), size: Map.put(ds.size, key, 1)}
          {ds, key}
      end
    end

    def union(ds, a, b) do
      {ds, root_a} = find(ds, a)
      {ds, root_b} = find(ds, b)

      if root_a != root_b do
        size_a = ds.size[root_a]
        size_b = ds.size[root_b]

        if size_a < size_b do
          parent = Map.put(ds.parent, root_a, root_b)
          size = Map.put(ds.size, root_b, size_a + size_b)
          %{ds | parent: parent, size: size}
        else
          parent = Map.put(ds.parent, root_b, root_a)
          size = Map.put(ds.size, root_a, size_a + size_b)
          %{ds | parent: parent, size: size}
        end
      else
        ds
      end
    end

    def sizes(%DisjointSet{parent: parent, size: size}) do
      parent
      |> Enum.filter(&(elem(&1, 0) == elem(&1, 1)))
      |> Enum.map(&size[elem(&1, 1)])
    end
  end
end
