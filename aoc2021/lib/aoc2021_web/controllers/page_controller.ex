defmodule Aoc2021Web.PageController do
  use Aoc2021Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
