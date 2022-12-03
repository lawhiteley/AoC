defmodule Day003 do

  def in_both_compartments_score(rucksacks) do
    rucksacks |> Enum.map(fn r ->
      common = find_common_items(get_compartments(r) |> Enum.map(&String.to_charlist/1))
      score_item(common)
    end) |> Enum.sum()
  end

  def find_badges(rucksacks, group_size \\ 3) do
    rucksacks
    |> Enum.chunk_every(group_size)
    |> Enum.map(&find_badge/1)
    |> Enum.map(&score_item/1)
    |> Enum.sum()
  end

  defp get_compartments(rucksack) do
    {_, regex} = Regex.compile(".{#{div(String.length(rucksack), 2)}}")
    String.split(rucksack, regex, include_captures: true, trim: true)
  end

  defp find_common_items(compartments) do
    [first, second] = compartments
    List.to_string(Enum.uniq(first -- (first -- second)))
  end

  defp find_badge(rucksacks) do
    [first, second, third] = rucksacks |> Enum.map(&String.to_charlist/1)
    List.to_string(Enum.uniq(third -- (third -- (first -- (first -- second)))))
  end

  defp score_item(<<item::utf8, _::binary>>) when item <= ?z and item >= ?a, do: item - ?a + 1
  defp score_item(<<item::utf8, _::binary>>) when item <= ?Z and item >= ?A, do: item - ?A + 27
  defp score_item(_), do: :error
end
