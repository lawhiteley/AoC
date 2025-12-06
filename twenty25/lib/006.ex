defmodule Day006 do

  def calculate_vertical(worksheet) do
    [operands | values] = Enum.reverse(worksheet) |> Enum.map(&(String.split(&1, " ", trim: true)))

    Enum.zip_with(values, &Function.identity/1)
    |> Enum.zip(operands)
    |> Enum.map(&calculate/1)
    |> Enum.sum()
  end

  def calculate_right_to_left(worksheet) do
    [operands | values] = Enum.reverse(worksheet)

    values |> Enum.map(&String.graphemes/1)
    |> Enum.zip_with(&Function.identity/1)
    |> Enum.chunk_by(&column?/1) |> Enum.reject(&(column?(hd(&1))))
    |> Enum.map(fn column ->
      Enum.map(column, &(Enum.reverse(&1) |> Enum.join() |> String.trim()))
    end)
    |> Enum.zip(String.split(operands, " ", trim: true))
    |> Enum.map(&calculate/1)
    |> Enum.sum()
  end

  defp calculate({values, operand}) do
    values = Enum.map(values, &String.to_integer/1)

    case operand do
      "+" -> Enum.sum(values)
      "*" -> Enum.product(values)
    end
  end

  def column?(list), do: Enum.all?(list, &(&1 == " "))
end
