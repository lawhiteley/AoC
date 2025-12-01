defmodule Day001 do
  def count_zero_visits(instructions, start \\ 50) do
    Enum.scan(instructions, start, &rotate(&1, &2)) |> Enum.count(&(&1 == 0))
  end

  def rotate("L" <> amount, location) do
    amount = String.to_integer(amount)

    if location - amount < 0 do
      rem(100 - abs(location - amount), 100)
    else
      rem(location - amount, 100)
    end
  end

  def rotate("R" <> amount, location) do
    rem(location + String.to_integer(amount), 100)
  end
end
