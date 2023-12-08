defmodule Day007 do

  def score_bets(bets, part \\ :one) do
    Enum.sort(Enum.sort_by(bets|> Enum.map(&process_bet(&1, part)), fn {_, _, rank} -> rank end, :desc),
    fn {_, hand1, score1}, {_, hand2, score2} -> if score1 == score2 do tiebreaker(hand1, hand2, part) else false end end)
    |> Enum.with_index(1)
    |> Enum.map(fn {{bid, _, _}, rank} -> bid * rank end) |> Enum.sum()
  end

  defp process_bet(bet, part) do
    [hand, bid] = String.split(bet, " ", trim: true)
    {bid, _} = Integer.parse(bid)
    hand = hand |> String.graphemes() |> Enum.map(&card_to_rank(&1, part))
    {bid, hand, score_hand(hand, part)}
  end

  defp score_hand(cards, :two) do
    frequencies = cards |> Enum.frequencies()
    joker_count = Map.get(frequencies, 1, 0)
    unique_cards = map_size(frequencies |> Map.delete(1))
    most_frequent = frequencies |> Map.delete(1) |> Enum.group_by(fn {_, count} -> count end)
    score = if Enum.empty?(most_frequent) do 11 else
      {count, _} = Enum.max(most_frequent)
      4 + (count + joker_count) - unique_cards
    end

    if score > 6 do 7 + 4 else score + 4 end
  end

  defp score_hand(cards, _) do
    unique_cards = length(Enum.uniq(cards))
    {count, _} = cards |> Enum.frequencies() |> Enum.group_by(fn {_, count} -> count end) |> Enum.max()
    4 + count - unique_cards
  end

  defp card_to_rank(card, _) when is_integer(card) do card end
  defp card_to_rank(card, part) do
    case Integer.parse(card) do
      {rank, _} -> rank
      _ -> Map.get(%{"T" => 10, "J" => if part == :one do 11 else 1 end, "Q" => 12, "K" => 13, "A" => 14}, card)
    end
  end

  defp tiebreaker(hand1, hand2, part) do
    {a, b} = Enum.zip(hand1, hand2) |> Enum.find(fn {a, b} -> a != b end)
    card_to_rank(a, part) <= card_to_rank(b, part)
  end
end
