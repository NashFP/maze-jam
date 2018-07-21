defmodule GeneratorTest do
  use ExUnit.Case
  alias Generator.Maze
  doctest Generator

  setup do
    %{maze: Maze.make(3, 3, true)}
  end

  test "greets the world" do
    assert Generator.hello() == :world
  end

  test "has all spots", %{maze: maze} do
    assert find(maze, 0, 0) != nil
    assert find(maze, 0, 1) != nil
    assert find(maze, 0, 2) != nil
    assert find(maze, 1, 0) != nil
    assert find(maze, 1, 1) != nil
    assert find(maze, 1, 2) != nil
    assert find(maze, 2, 0) != nil
    assert find(maze, 2, 1) != nil
    assert find(maze, 2, 2) != nil
  end


  # Helpers
  defp find(maze, x, y) do
    Enum.find(maze, & &1.x == x and &1.y == y)
  end
end
