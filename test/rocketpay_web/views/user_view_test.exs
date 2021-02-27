defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  test "renders create.json" do
    params = %{
      name: "Saulo",
      password: "123456",
      nickname: "egito",
      email: "segito@gmail.com",
      age: 41
    }

    {:ok,
     %User{
       id: user_id,
       account: %Account{id: account_id}
     } = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        id: user_id,
        name: "Saulo",
        nickname: "egito"
      }
    }

    assert expected == response
  end
end
