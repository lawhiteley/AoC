defmodule TestHelper do
  def file_to_ints(file_path) do
    file_to_strings(file_path)
    |> Enum.map(fn x ->
      case x do
        "" -> x
        _ -> String.to_integer(x)
      end
    end)
  end

  def file_to_string(file_path) do
    {_, contents} = File.read(file_path)
    contents
  end

  def file_to_strings(file_path, trim_mode \\ :full) do
    contents = File.stream!(file_path)

    case trim_mode do
      :trailing -> contents |> Enum.map(&String.trim_trailing/1)
      _ -> contents |> Enum.map(&String.trim/1)
    end
  end
end

ExUnit.start()
