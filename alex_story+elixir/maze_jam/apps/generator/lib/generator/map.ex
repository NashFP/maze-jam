defmodule Generator.Map do
  def make(x, y) do
    for h <- 0..x-1, v <- 0..y-1 do
      {h,v, %Generator.Cell{}}
    end
  end
end
