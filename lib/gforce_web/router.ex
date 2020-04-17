defmodule GforceWeb.Router do
  use GforceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GforceWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", GforceWeb do
    pipe_through :api

    post "/auth", AuthController, :index
    post "/recognize", RecognitionController, :index
  end
end
