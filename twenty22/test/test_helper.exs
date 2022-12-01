defmodule TestHelper do

  def file_to_ints(file_path) do
    file_to_strings(file_path) |> Enum.map(fn x ->
      case x do
        "" -> x
        _ -> String.to_integer(x)
      end
    end)
  end

  def file_to_strings(file_path) do
    File.stream!(file_path) |> Enum.map(&String.trim/1)
  end
end

ExUnit.start()
