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
end
