defmodule Generator.Cell do
  @moduledoc """
  Module for working with an individual cell in the maze
  """
  alias __MODULE__
  defstruct north: nil,
    south: nil,
    east: nil,
    west: nil,
    x: 0,
    y: 0

  @doc """
  Returns the bitstring value for a [cell]

  ## Examples
       c = %Generator.Cell{north: true}
       c |> get_bitstring
       1
  """
  def get_bitstring (cell) do
    0
    |> add_north(cell)
    |> add_south(cell)
    |> add_east(cell)
    |> add_west(cell)
  end

  def new(bitstring, cell \\ %Cell{}) do
    with {cell, n} <- set_west(cell, bitstring),
         {cell, n} <- set_east(cell, n),
         {cell, n} <- set_south(cell, n),
         {cell,n} <- set_north(cell, n)
    do
      cell
    end
  end

  def to_tuple(cell), do: {cell.x, cell.y, get_bitstring(cell)}
  def to_simple(cell), do: %{x: cell.x, y: cell.y, value: get_bitstring(cell)}

  defp add_north(n, %Cell{north: true}), do: n + 1
  defp add_north(n, _), do: n

  defp add_south(n, %Cell{south: true}), do: n + 2
  defp add_south(n, _), do: n

  defp add_east(n, %Cell{east: true}), do: n + 4
  defp add_east(n, _), do: n

  defp add_west(n, %Cell{west: true}), do: n + 8
  defp add_west(n, _), do: n

  defp set_west(cell, n) when n >= 8, do: {Map.put(cell, :west, true), n - 8}
  defp set_west(cell, n), do: {Map.put(cell, :west, false), n}

  defp set_east(cell, n) when n >= 4, do: {Map.put(cell, :east, true), n - 4}
  defp set_east(cell, n), do: {Map.put(cell, :east, false), n}

  defp set_south(cell, n) when n >= 2, do: {Map.put(cell, :south, true), n - 2}
  defp set_south(cell, n), do: {Map.put(cell, :south, false), n}

  defp set_north(cell, n) when n >= 1, do: {Map.put(cell, :north, true), n - 1}
  defp set_north(cell, n), do: {Map.put(cell, :north, false), n}
end

