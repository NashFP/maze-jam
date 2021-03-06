defmodule Generator.Maze do
  @moduledoc """
  Module for handling the overall maze.
  Mazes are being represented as a list Cells
  """
  alias Generator.Cell

  @doc """
  Makes a new maze of Cells with the width(x) and height (y)

  ## Examples
        m = Generator.Maze.make 1, 1
        m
        [{%Cell{x: 0, y: 0, north: false, south: false, east: false, west: false}]
  """
  def make(x, y) do
    maze =
      new(x,y)
      |> init_borders

    maze
    |> Enum.map(&set_east(&1, maze))
    |> Enum.map(&set_west(&1, maze))
    |> Enum.map(&set_north(&1, maze))
    |> Enum.map(&set_south(&1, maze))
  end

  @doc """
  Makes a new maze, using randomized bitstrings
  """
  def make(x, y, true) do
    new(x, y)
    |> Enum.map(&Cell.new(rand_bitstring(), &1))
  end

  @doc """
  Converts a maze into a doubly nested list of bitstrings.
  """
  def to_json(maze) do
    0..max_height(maze)
    |> Enum.map(fn v ->
      0..max_width(maze)
      |> Enum.map(fn h ->
        Enum.find(maze, & &1.y == v and &1.x == h)
        |> Cell.get_bitstring
      end)
    end)
  end

  @doc """
  Returns the example maze
  """
  def example do
    maze = [
      [ 2, 14, 10, 14,  8 ],
      [ 5,  9, 11, 13, 11 ],
      [ 3, 15,  9, 15,  9 ],
      [ 7, 15, 13, 15, 11 ],
      [ 1, 13,  9,  9,  9 ]
    ]
    maze
  end

#### Private functions

  defp init_borders(maze) do
    ## Initialize max's so they aren't calculated every time through loop
    height = max_height(maze)
    width = max_width(maze)

    maze
    |> Enum.map(fn cell -> if cell.x == 0, do: Map.put(cell, :north, true), else: cell end)
    |> Enum.map(fn cell -> if cell.x == height, do: Map.put(cell, :south, true), else: cell end)
    |> Enum.map(fn cell -> if cell.y == 0, do: Map.put(cell, :west, true), else: cell end)
    |> Enum.map(fn cell -> if cell.y == width, do: Map.put(cell, :east, true), else: cell end)
  end

  defp max_width(maze) do
    maze
    |> Enum.max_by(fn cell -> cell.x end)
    |> Map.get(:x)
  end

  defp max_height(maze) do
    maze
    |> Enum.max_by(fn cell -> cell.y end)
    |> Map.get(:y)
  end

  defp set_east(cell, maze) do
    east = get_east(cell, maze)
    cond do
      cell.east != nil  -> cell
      east == nil       -> Map.put(cell, :east, rand_bool())
      east.west != nil  -> Map.put(cell, :east, east.west)
      true              -> Map.put(cell, :east, rand_bool())
    end
  end

  defp set_west(cell, maze) do
    west = get_west(cell, maze)
    cond do
      cell.west != nil  -> cell
      west == nil       -> Map.put(cell, :west, rand_bool())
      west.east != nil  -> Map.put(cell, :west, west.east)
      true              -> Map.put(cell, :west, rand_bool())
    end
  end

  defp set_north(cell, maze) do
    north = get_north(cell, maze)
    cond do
      cell.north != nil   -> cell
      north == nil        -> Map.put(cell, :north, rand_bool())
      north.south == nil  -> Map.put(cell, :north, rand_bool())
      true                -> Map.put(cell, :north, north.south)
    end
  end

  defp set_south(cell, maze) do
    south = get_south(cell, maze)
    cond do
      cell.south != nil   -> cell
      south == nil        -> Map.put(cell, :south, rand_bool())
      south.south == nil  -> Map.put(cell, :south, rand_bool())
      true                -> Map.put(cell, :south, south.north)
    end
  end
 
  defp new(x, y) do
    for h <- 0..x-1, v <- 0..y-1 do
                                %Cell{x: h, y: v}
    end
  end

  def get_west(cell, maze), do: Enum.find(maze, fn c -> c.x == cell.x + 1 && cell.y == c.y end)
  def get_east(cell, maze), do: Enum.find(maze, fn c -> c.x == cell.x - 1 && cell.y == c.y end)
  def get_north(cell, maze), do: Enum.find(maze, fn c -> c.x == cell.x && c.y == cell.y - 1 end)
  def get_south(cell, maze), do: Enum.find(maze, fn c -> c.x == cell.x && c.y == cell.y + 1 end)

  defp rand_bool, do: [true, false] |> Enum.random
  defp rand_bitstring, do: 1..15 |> Enum.random
end
