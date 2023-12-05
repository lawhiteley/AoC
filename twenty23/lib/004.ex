defmodule Day004 do

  def score_cards(cards) do
    cards |> Enum.map(fn card ->
      [_, game] = String.split(card, ":")
      score_card(game)
    end) |> Enum.map(&calculate_score/1) |> Enum.sum()
  end

  def how_many_cards(cards) do
    card_map = Map.new(cards |> Enum.map(&String.split(&1, ":")), fn [c, n] -> {Regex.run(~r/\d+/, c) |> List.first() |> String.to_integer(), [n]} end)
    ordered_keys = card_map |> Map.keys()|> Enum.sort()

    Enum.reduce(ordered_keys, card_map, fn card, acc ->
        copies = Map.get(acc, card)
        number_of_winners = length(score_card(List.first(copies)))
        if number_of_winners > 0 do
          update_downstream_cards(card, number_of_winners, length(copies), acc)
        else
          acc
        end
      end) |> Map.values() |> List.flatten() |> length()
  end

  defp update_downstream_cards(card, number_of_winners, copies, map) do
    (card + 1)..(card + number_of_winners) |> Enum.reduce(map, fn i, map ->
      Map.update(map, i, copies, fn existing -> existing ++ List.duplicate(List.first(existing), copies) end)
    end)
  end

  defp score_card(game) do
    [winners, numbers] = String.split(game, ["|"], trim: true) |> Enum.map(&String.split(&1, " ", trim: true)) |> Enum.map(fn x -> Enum.map(x, &(String.to_integer/1)) end) |> Enum.map(&MapSet.new/1)
    MapSet.intersection(winners, numbers) |> Enum.to_list()
  end

  defp calculate_score(winners) when length(winners) <= 0 do 0 end
  defp calculate_score(winners) when length(winners) == 1 do 1 end
  defp calculate_score(winners) do trunc(:math.pow(2, length(winners) - 1)) end
end
