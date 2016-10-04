defmodule Wubytex.AuthController do
  use Wubytex.Web, :controller
  plug Ueberauth #, providers: [:identity], base_path: "/auth"

  def sign_in(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case validate_password(auth) do
      :ok ->
        user = %{id: auth.uid, username: auth.extra.raw_info["username"]}
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> redirect(to: "/")
      { :error, reason } ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  def sign_up(conn, params) do
    conn |> put_flash(:info, "sign up") |> redirect(to: "/")
  end

  def sign_out(conn, _params) do
    conn
    |> put_flash(:error, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def validate_password(auth) do
    :ok
    # {:error, "#{inspect(auth)}"}
  end
end
