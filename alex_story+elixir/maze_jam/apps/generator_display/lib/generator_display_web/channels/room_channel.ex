defmodule GeneratorDisplayWeb.RoomChannel do
  use Phoenix.Channel
  alias Generator.Maze

  def join("room:home", _message, socket) do
    {:ok, socket}
  end

  def handle_in("get_maze", %{"cols" => cols, "rows" => rows}, socket) do
    c = String.to_integer cols
    r = String.to_integer rows
    maze =
      Maze.make(r, c, true)
      |> Maze.to_json
    IO.inspect maze
    broadcast! socket, "new_maze", %{maze: maze}
    {:noreply, socket}
  end

  def handle_in("get_maze", _message, socket) do
    maze =
      Generator.Maze.make(10,10)
    broadcast! socket, "new_maze", %{maze: maze}
  end
end
