defmodule Day004 do

  def overlapping_assignments(assignments) do
    assignments
    |> Enum.map(&parse_assignment/1)
    |> Enum.count(&assignments_overlap?/1)
  end

  def intersecting_assignments(assignments) do
    assignments
    |> Enum.map(&parse_assignment/1)
    |> Enum.count(&assignments_intersect?/1)
  end

  defp assignments_overlap?(assignments) do
    [a, b] = assignments
    MapSet.subset?(a, b) or MapSet.subset?(b, a)
  end

  defp assignments_intersect?(assignments) do
    [a, b] = assignments
    MapSet.intersection(a, b) !== MapSet.new()
  end

  defp parse_assignment(assignment) do
    String.split(assignment, ",")
    |> Enum.map(fn range ->
      [a, b] = String.split(range, "-") |> Enum.map(&String.to_integer/1)
      MapSet.new(a..b)
    end)
  end
end
