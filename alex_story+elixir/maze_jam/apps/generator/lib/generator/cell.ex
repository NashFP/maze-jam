defmodule Generator.Cell do
  alias __MODULE__
  defstruct north: false,
    south: false,
    east: false,
    west: false,
    x: 0,
    y: 0

  def get_bitstring (cell) do
    0
    |> add_north(cell)
    |> add_south(cell)
    |> add_east(cell)
    |> add_west(cell)
  end

  def add_north(n, %Cell{north: true}), do: n + 1
  def add_north(n, _), do: n

  def add_south(n, %Cell{south: true}), do: n + 2
  def add_south(n, _), do: n

  def add_east(n, %Cell{east: true}), do: n + 4
  def add_east(n, _), do: n

  def add_west(n, %Cell{west: true}), do: n + 8
  def add_west(n, _), do: n
end
