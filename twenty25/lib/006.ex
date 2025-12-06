defmodule Day006 do

  def calculate_vertical(worksheet) do
    [operands | values] = Enum.reverse(worksheet) |> Enum.map(&(String.split(&1, " ", trim: true)))

    Enum.zip_with(values, &Function.identity/1)
    |> Enum.zip(operands)
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
end
