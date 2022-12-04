defmodule Day003 do

  def in_both_compartments_score(rucksacks) do
    rucksacks |> Enum.map(fn r ->
      common = find_common_items(get_compartments(r))
      score_item(common)
    end) |> Enum.sum()
  end

  def score_of_badges(rucksacks) do
    rucksacks
    |> Enum.chunk_every(3)
    |> Enum.map(&find_badge/1)
    |> Enum.map(&score_item/1)
    |> Enum.sum()
  end

  defp get_compartments(rucksack) do
    {_, regex} = Regex.compile(".{#{div(String.length(rucksack), 2)}}")
    String.split(rucksack, regex, include_captures: true, trim: true)
  end

  defp find_common_items(compartments) do
    [first, second] = compartments |> Enum.map(&String.to_charlist/1)
    List.to_string(Enum.uniq(first -- (first -- second)))
  end

  defp find_badge(rucksacks) do
    [first, second, third] = rucksacks |> Enum.map(&String.to_charlist/1)
    List.to_string(Enum.uniq(third -- (third -- (first -- (first -- second)))))
  end

  defp score_item(<<item::utf8, _::binary>>) when item >= ?a and item <= ?z, do: item - ?a + 1
  defp score_item(<<item::utf8, _::binary>>) when item >= ?A and item <= ?Z, do: item - ?A + 27
  defp score_item(_), do: :error
end
