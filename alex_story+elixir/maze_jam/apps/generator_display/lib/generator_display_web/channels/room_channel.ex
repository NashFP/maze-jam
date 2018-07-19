defmodule GeneratorDisplayWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:home", _message, socket) do
    {:ok, socket}
  end

  def handle_in("get_maze", %{"cols" => cols, "rows" => rows}, socket) do
    maze =
      Generator.Maze.make(String.to_integer(rows), String.to_integer(cols))
    broadcast! socket, "new_maze", %{maze: maze}
  end

  def handle_in("get_maze", _message, socket) do
    maze =
      Generator.Maze.make(10,10)
    broadcast! socket, "new_maze", %{maze: maze}
  end
end
