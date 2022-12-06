defmodule Day006 do

  def find_marker(signal, chunk_size \\ 4) do
    {_ , marker} = String.graphemes(signal)
    |> Enum.chunk_every(chunk_size, 1, :discard)
    |> Enum.with_index() |> Enum.filter(fn {x, _} -> length(Enum.uniq(x)) == chunk_size end)
    |> hd()

    marker + chunk_size
  end
end
