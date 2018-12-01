defmodule Day1 do
  def adjustFrequencyFromFile(filename) do
    case File.read(filename) do
      {:ok, file} ->
        processFile(file)

      {:error, :enoent} ->
        "This file does not exists"

      {:error, reason} ->
        "An unknown error happened while loading the file #{filename}, #{reason}"
    end
  end

  def adjustFrequency(input, starting \\ %Day1.Frequencies{}) do
    reset = %{starting | adjusted: 0}
    result = Enum.reduce(input, reset, fn x, acc -> reduceFrequencies(x, acc) end)
    %{result | tries: result.tries + 1}
  end

  defp reduceFrequencies(change, accumulator) do
    adjusted = accumulator.adjusted + change
    global = accumulator.current + change

    first_repeating =
      case Enum.member?(accumulator.seen, global) do
        true -> accumulator.first_repeating || global
        false -> accumulator.first_repeating
      end

    %{
      accumulator
      | adjusted: adjusted,
        current: global,
        seen: accumulator.seen ++ [adjusted],
        first_repeating: first_repeating
    }
  end

  def findRepeatingFrequency(input, starting \\ %Day1.Frequencies{}) do
    result = adjustFrequency(input, starting)

    case result do
      %{tries: 10000} -> result
      %{first_repeating: nil} -> findRepeatingFrequency(input, result)
      _ -> result
    end
  end

  defp processFile(file) do
    String.split(file, "\n")
    |> Enum.filter(fn input -> filterBadInput(input) end)
    |> Enum.map(fn input -> String.to_integer(input) end)
    |> findRepeatingFrequency
  end

  defp filterBadInput(string) do
    case Integer.parse(string) do
      {_, _} -> true
      :error -> false
    end
  end
end
