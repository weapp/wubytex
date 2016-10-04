defmodule Wubytex.PageController do
  use Wubytex.Web, :controller

  alias Ueberauth.Strategy.Helpers

  def index(conn, _params) do
    render conn, "index.html", callback_url: Helpers.callback_url(conn),
                               current_user: get_session(conn, :current_user)
  end
end
