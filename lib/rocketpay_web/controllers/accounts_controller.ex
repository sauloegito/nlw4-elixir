defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller
  alias Rocketpay.Account

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      handle_sucess(conn, account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      handle_sucess(conn, account)
    end
  end

  defp handle_sucess(conn, account) do
    conn
    |> put_status(:ok)
    |> render("update.json", account: account)
  end

end
