defmodule Day002 do

  def parse_games(games, cube_counts) do
    games |> Enum.map(&parse_game(&1, cube_counts)) |> Enum.sum()
  end

  defp parse_game(game, cube_counts) do
    [game, turns] = String.split(game, ":")
    if game_is_possible?(String.split(turns, ";"), cube_counts) do
      [game_number] = Regex.run(~r/\d+/, game)
      String.to_integer(game_number)
    else
      0
    end
  end

  defp game_is_possible?(turn, cube_counts) do
    turn |> Enum.all?(fn reveal ->
      Regex.scan(~r/(\d+) (\w+)/, reveal)
      |> Enum.all?(fn [_, count, colour] ->
        String.to_integer(count) <= Map.get(cube_counts, String.to_atom(colour))
      end)
    end)
  end

  def sum_powers(games) do
    games |> Enum.map(&calculate_power/1) |> Enum.sum()
  end

  defp calculate_power(game) do
    [_, reveals] = String.split(game, ":")
    Enum.reduce(Regex.scan(~r/(\d+) (\w+)/, reveals), %{"blue" => 0, "green" => 0, "red" => 0}, fn [_, count, colour], acc ->
      Map.update(acc, colour, 0, &(Kernel.max(&1, String.to_integer(count))))
     end)
    |> Map.values() |> Enum.product()
  end
end
