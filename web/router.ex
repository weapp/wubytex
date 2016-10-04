defmodule Wubytex.Router do
  use Wubytex.Web, :router

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

  scope "/", Wubytex do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Wubytex do
  #   pipe_through :api
  # end

  scope "/auth", Wubytex do
    pipe_through :browser

    # get "/:provider", AuthController, :request
    # get "/:provider/callback", AuthController, :callback
    # post "/identity/callback", AuthController, :identity_callback
    post "/signup", AuthController, :sign_up
    post "/signin", AuthController, :sign_in
    post "/signout", AuthController, :sign_out
  end

  # scope "/auth", Wubytex do
  #   pipe_through :browser

  #   # get "/:provider", AuthController, :request
  #   # get "/:provider/callback", AuthController, :callback
  #   post "/identity/callback", AuthController, :identity_callback
  # end
end
