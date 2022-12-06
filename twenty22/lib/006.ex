defmodule Day006 do

  def find_marker(signal, chunk_size \\ 4) do
    marker = String.graphemes(signal)
    |> Enum.chunk_every(chunk_size, 1, :discard)
    |> Enum.filter(fn x -> length(Enum.uniq(x)) == chunk_size end)
    |> hd() |> Enum.join()

    {start, len} = :binary.match(signal, marker) # I know how lazy this is
    start + len
  end
end
