defmodule GforceWeb.AuthController do
    use GforceWeb, :controller
    require Logger
  
    def index(conn, _params) do
      Logger.info "Auth controller called"
      conn
    end
  end
  