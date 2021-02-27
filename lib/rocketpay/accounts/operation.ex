defmodule Rocketpay.Accounts.Operation do
  alias Ecto.Multi
  alias Rocketpay.{Account, Repo}

  def call(%{"id" => id, "value" => value}, operation) do
    opr_name = account_operation_name(operation)

    Multi.new()
    |> Multi.run(opr_name, fn repo, _changes ->
      get_account(repo, id)
    end)
    |> Multi.run(operation, fn repo, changes ->
      account = Map.get(changes, opr_name)
      update_balance(repo, account, value, operation)
    end)
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value, operation) do
    account
    |> operate_values(value, operation)
    |> update_account(account, repo)
  end

  defp operate_values(%Account{balance: balance}, value, operation) do
    value
    |> Decimal.cast()
    |> handle_cast(balance, operation)
  end

  defp handle_cast({:ok, value}, balance, :deposit), do: Decimal.add(balance, value)
  defp handle_cast({:ok, value}, balance, :withdraw), do: Decimal.sub(balance, value)
  defp handle_cast(:error, _balance, _operation), do: {:error, "Invalid operation!"}

  defp update_account({:error, _reason} = error, _account, _repo), do: error

  defp update_account(new_balance, account, repo) do
    %{balance: new_balance}
    |> Account.changeset(account)
    |> repo.update()
  end

  defp account_operation_name(operation) do
    "account_#{Atom.to_string(operation)}"
    |> String.to_atom()
  end
end
