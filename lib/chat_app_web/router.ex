defmodule ChatAppWeb.Router do
  use ChatAppWeb, :router

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

  scope "/", ChatAppWeb do
    pipe_through :browser


    get "/", PageController, :index
    post "/rooms", RoomController, :enter
    get "/:name/rooms", RoomController, :index
    get "/:name/rooms/new", RoomController, :new
    get "/:name/rooms/:id", RoomController, :show
    post "/:name/rooms", RoomController, :create
    delete "/:name/rooms/:id", RoomController, :delete
    post "/:name/rooms/:id/messages", MessageController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatAppWeb do
  #   pipe_through :api
  # end
end
