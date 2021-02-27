defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      test_name = "Saulo"
      test_age = 41

      params = %{
        name: test_name,
        password: "123456",
        nickname: "egito",
        email: "segito@gmail.com",
        age: test_age
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: ^test_name, age: ^test_age, id: ^user_id} = user
    end

    test "when therar are invalid params, returns an error" do
      params = %{
        name: "Saulo",
        nickname: "egito",
        email: "segito@gmail.com",
        age: 14
      }

      {:error, changeset} = Create.call(params)

      expected = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert expected == errors_on(changeset)
    end
  end
end
