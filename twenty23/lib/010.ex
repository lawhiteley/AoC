defmodule Day010 do

  @direction %{
    :north => {0, 1},
    :east => {-1, 0},
    :south => {0, -1},
    :west => {1, 0}
  }

  @opposite_direction %{
    :north => :south,
    :south => :north,
    :east => :west,
    :west => :east
  }

  @pipe_types %{
    "|" => [:north, :south],
    "-" => [:east, :west],
    "L" => [:north, :east],
    "J" => [:north, :west],
    "7" => [:south, :west],
    "F" => [:south, :east],
  }

  def farthest_point(map) do
    cycle = generate_pipe_system_map(map)
    farthest_away = Enum.at(cycle, div(length(cycle), 2))
    Enum.find_index(cycle, &(&1 == farthest_away))
  end

  # The boys: https://en.wikipedia.org/wiki/Shoelace_formula and https://en.wikipedia.org/wiki/Pick%27s_theorem
  def points_inside_loop(map) do
    cycle = generate_pipe_system_map(map)

    area = Kernel.abs(cycle ++ [List.first(cycle)]
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [{x1, y1}, {x2, y2}] ->
        (x2 * y1) - (x1 * y2)
      end) |> Enum.sum()
    ) / 2

    Kernel.round(area - 0.5 * length(cycle) + 1)
  end

  defp generate_pipe_system_map(map) do
    coordinates = build_grid(map)
    starting_pos = coordinates |> Enum.find(fn {_, v} -> v == "S" end) |> elem(0)
    {pipe, relative_direction, relative_location} = Enum.reduce(Map.keys(@direction), {}, fn direction, acc ->
      plot = get(coordinates, starting_pos, direction)
      if is_a_connected_pipe?(plot, direction) do {plot,  direction, Map.get(@direction, direction)} else acc end
    end)

    next_pipe_location = transform_coordinates(starting_pos, relative_location)
    traverse_pipe_system(coordinates, pipe, next_pipe_location, relative_direction, [starting_pos, next_pipe_location])
  end

  defp is_a_connected_pipe?(plot, direction) do
    plot in Map.keys(@pipe_types) and Map.get(@opposite_direction, direction) in Map.get(@pipe_types, plot)
  end

  defp traverse_pipe_system(map, pipe_type, pipe_location, direction, pipes) do
    if pipe_type == "S" do pipes else
      [next_direction] = Map.get(@pipe_types, pipe_type) |> Enum.filter(&(&1 !== Map.get(@opposite_direction, direction)))
      next_pipe = get(map, pipe_location, next_direction)
      next_location = transform_coordinates(pipe_location, Map.get(@direction, next_direction))

      traverse_pipe_system(map, next_pipe, next_location, next_direction, pipes ++ [next_location])
    end
  end

  defp build_grid(map) do
    indexed = Enum.with_index(Enum.map(map, fn row -> String.graphemes(row) |> Enum.with_index() end))
    Enum.reduce(indexed, %{}, fn {row, y}, acc ->
      Enum.reduce(row, acc, fn {char, x}, acc -> Map.put(acc, {-x, -y}, char) end)
    end)
  end

  defp get(map, start, direction) do Map.get(map, transform_coordinates(start, Map.get(@direction, direction))) end

  defp transform_coordinates({x1, y1}, {x2, y2}) do {x1 + x2, y1 + y2} end
end
