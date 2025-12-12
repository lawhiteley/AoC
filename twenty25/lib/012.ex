defmodule Day012 do
  def count_sufficient_regions(instructions) do
    parse_regions(hd(String.split(instructions, "\n\n") |> Enum.reverse()))
    |> Enum.map(fn {size, quantities} ->
      available_area = String.split(size, "x") |> Enum.map(&String.to_integer/1) |> Enum.product()
      used_area = Enum.sum(quantities) * 7
      {available_area, used_area}
    end)
    |> Enum.count(fn {available, used} -> used <= available end)
  end

  defp parse_regions(regions) do
    String.split(regions, "\n")
    |> Enum.map(fn region ->
      [size | quantities] = String.split(region, ":")
      {size, Enum.map(String.split(hd(quantities)), &String.to_integer/1)}
    end)
  end
end
