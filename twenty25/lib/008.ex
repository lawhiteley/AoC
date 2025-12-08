defmodule Day008 do
  alias Day008.DisjointSet

  def three_largest_circuits(rows, desired_connections \\ 10) do
    circuits =
      combinations(2, parse_xyz(rows))
      |> Enum.map(fn [a, b] -> {[a, b], euclidian_distance(a, b)} end)
      |> Enum.sort_by(&elem(&1, 1))
      |> Enum.take(desired_connections)
      |> Enum.reduce(DisjointSet.new(), fn {[a, b], _}, acc ->
        {_, updated} = DisjointSet.union(acc, a, b)
        updated
      end)

    DisjointSet.top_n(circuits, 3) |> Enum.product()
  end

  def last_two_in_circuit(rows) do
    combinations(2, parse_xyz(rows))
    |> Enum.map(fn [a, b] -> {[a, b], euclidian_distance(a, b)} end)
    |> Enum.sort_by(&elem(&1, 1))
    |> Enum.reduce_while(DisjointSet.new(), fn {[a, b], _}, acc ->
      {_, updated} = DisjointSet.union(acc, a, b)

      if length(DisjointSet.sizes(updated)) == 1 and
           hd(DisjointSet.sizes(updated)) == length(rows) do
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
    :math.sqrt(
      :math.pow(p2.x - p1.x, 2) +
        :math.pow(p2.y - p1.y, 2) +
        :math.pow(p2.z - p1.z, 2)
    )
  end

  # From https://rosettacode.org/wiki/Combinations#Elixir
  def combinations(0, _), do: [[]]
  def combinations(_, []), do: []

  def combinations(m, [h | t]) do
    for(l <- combinations(m - 1, t), do: [h | l]) ++ combinations(m, t)
  end

  defmodule DisjointSet do
    defstruct parent: %{}, size: %{}

    def new(), do: %__MODULE__{}

    def find(%DisjointSet{} = DisjointSet, key) do
      case Map.fetch(DisjointSet.parent(), key) do
        {:ok, parent} ->
          if parent == key do
            {DisjointSet, key}
          else
            {DisjointSet, root} = find(DisjointSet, parent)
            {%{DisjointSet | parent: Map.put(DisjointSet.parent(), key, root)}, root}
          end

        :error ->
          DisjointSet = %{
            DisjointSet
            | parent: Map.put(DisjointSet.parent(), key, key),
              size: Map.put(DisjointSet.size(), key, 1)
          }

          {DisjointSet, key}
      end
    end

    def union(DisjointSet, a, b) do
      {DisjointSet, root_a} = find(DisjointSet, a)
      {DisjointSet, root_b} = find(DisjointSet, b)

      if root_a != root_b do
        size_a = DisjointSet.size()[root_a]
        size_b = DisjointSet.size()[root_b]

        if size_a < size_b do
          parent = Map.put(DisjointSet.parent(), root_a, root_b)
          size = Map.put(DisjointSet.size(), root_b, size_a + size_b)
          {true, %{DisjointSet | parent: parent, size: size}}
        else
          parent = Map.put(DisjointSet.parent(), root_b, root_a)
          size = Map.put(DisjointSet.size(), root_a, size_a + size_b)
          {true, %{DisjointSet | parent: parent, size: size}}
        end
      else
        {false, DisjointSet}
      end
    end

    def sizes(%DisjointSet{parent: parent, size: size}) do
      parent
      |> Enum.filter(fn {key, value} -> key == value end)
      |> Enum.map(fn {root, _} -> size[root] end)
    end

    def top_n(DisjointSet, n) do
      sizes(DisjointSet)
      |> Enum.sort(:desc)
      |> Enum.take(n)
    end
  end
end
