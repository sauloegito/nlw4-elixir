defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      handle_account_sucess(conn, account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      handle_account_sucess(conn, account)
    end
  end

  def transfer(conn, params) do
    with {:ok, %TransactionResponse{} = transfer} <- Rocketpay.transfer(params) do
      conn
      |> put_status(:ok)
      |> render("transfer.json", transfer: transfer)
    end
  end

  defp handle_account_sucess(conn, account) do
    conn
    |> put_status(:ok)
    |> render("update.json", account: account)
  end
end
