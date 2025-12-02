defmodule Day001 do
  def count_zero_visits(instructions, start \\ 50) do
    Enum.scan(instructions, {start, 0}, &rotate(&1, &2)) |> Enum.count(&(elem(&1, 0) == 0))
  end

  def count_of_clicks(instructions, start \\ 50),
    do: elem(Enum.reduce(instructions, {start, 0}, &rotate(&1, &2)), 1)

  defp rotate("L" <> amount, {location, clicks}) do
    rotate(String.to_integer(amount) * -1, {location, clicks})
  end

  defp rotate("R" <> amount, {location, clicks}) do
    rotate(String.to_integer(amount), {location, clicks})
  end

  defp rotate(amount, {location, clicks}) when is_integer(amount) do
    {rem(100 + rem(location + amount, 100), 100), clicks + count_clicks(amount, location)}
  end

  defp count_clicks(amount, location) do
    result = location + amount

    cond do
      result == 0 and location != 0 -> 1
      result > 0 or (location == 0 and result < 0) -> div(abs(result), 100)
      result < 0 -> div(abs(result), 100) + 1
    end
  end
end
