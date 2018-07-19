defmodule GeneratorDisplayWeb.PageController do
  use GeneratorDisplayWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
