defmodule Day007 do
  def count_splits(manifold) do
    traverse_manifold(manifold) |> elem(0)
  end

  def count_timelines(manifold) do
    Enum.sum_by(elem(traverse_manifold(manifold), 1), &elem(&1, 1))
  end

  defp traverse_manifold(manifold) do
    start = :binary.match(hd(manifold), "S") |> elem(0)

    Enum.reduce(tl(manifold), {0, [{start, 1}]}, fn next, {splits, beams} ->
      updated_splits = Enum.count(beams, fn {b, _} -> String.at(next, b) == "^" end)

      updated_beams = process_row(next, beams)

      {splits + updated_splits, updated_beams}
    end)
  end

  defp process_row(row, beams) do
    Enum.flat_map(beams, fn {location, timelines} ->
      if String.at(row, location) == "^" do
        [{location - 1, timelines}, {location + 1, timelines}]
      else
        [{location, timelines}]
      end
    end)
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    |> Enum.map(fn {location, timelines} -> {location, Enum.sum(timelines)} end)
  end
end
