defmodule GforceWeb.PageController do
  use GforceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
