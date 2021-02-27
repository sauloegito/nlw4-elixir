defmodule Rocketpay.Numbers do
  def fizzBuzz(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, file}) do
    result =
      file
      |> String.split(",")
      |> Enum.map(&convert_and_evaluate/1)

    # |> Enum.sum()
    {:ok, %{result: result}}
  end

  defp handle_file({:error, reason}), do: {:error, "Invalid File: #{reason}"}

  defp convert_and_evaluate(elem) do
    elem
    |> String.to_integer()
    |> evaluate()
  end

  defp evaluate(number) when rem(number, 3) == 0 and rem(number, 5) == 0, do: :fizzbuzz
  defp evaluate(number) when rem(number, 3) == 0, do: :fizz
  defp evaluate(number) when rem(number, 5) == 0, do: :buzz
  defp evaluate(number), do: number
end
