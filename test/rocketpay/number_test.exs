defmodule Rocketpay.NumbersTest do
  use ExUnit.Case, async: true

  describe "fizzBuzz/1" do
    test "when a valid file is provided, returns converted list" do
      expected = {:ok, %{result: [1, 2, :fizz, 4, :buzz, :buzz, :fizzbuzz, :buzz]}}
      assert Rocketpay.Numbers.fizzBuzz("numbers") == expected
    end

    test "when an invalid file is provided, returns an error" do
      expected = {:error, "Invalid File: enoent"}
      assert Rocketpay.Numbers.fizzBuzz("invalid") == expected
    end
  end
end
