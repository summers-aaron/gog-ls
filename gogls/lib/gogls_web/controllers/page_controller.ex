defmodule GoglsWeb.PageController do
  use GoglsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
