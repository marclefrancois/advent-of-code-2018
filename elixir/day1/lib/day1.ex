defmodule Day1.Frequencies do
  defstruct current: 0, adjusted: 0, seen: [], first_repeating: nil, tries: 0
end

defmodule Day1 do
  def run() do
    start = System.monotonic_time(unquote(:milli_seconds))

    IO.puts("-----------------------")
    IO.puts("Advent of code day 1 !")
    IO.puts("-----------------------")
    IO.puts("Answer for part 1")

    part1("../../inputFiles/day1/Input.txt")
    |> IO.puts()

    time_spent = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("took #{time_spent} milliseconds")
    IO.puts("-----------------------")
    IO.puts("Answer for part 2")

    part2("../../inputFiles/day1/Input.txt")
    |> IO.puts()

    time_spent = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("took #{time_spent} milliseconds")
    IO.puts("-----------------------")
  end

  def part1(filename) do
    case File.read(filename) do
      {:ok, file} ->
        processFile(file)
        |> Enum.sum()

      {:error, :enoent} ->
        "This file does not exists"

      {:error, reason} ->
        "An unknown error happened while loading the file #{filename}, #{reason}"
    end
  end

  def part2(filename) do
    case File.read(filename) do
      {:ok, file} ->
        result =
          processFile(file)
          |> findRepeatingFrequency

        result.first_repeating

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
    |> Enum.filter(&filterBadInput/1)
    |> Enum.map(&String.to_integer/1)
  end

  defp filterBadInput(string) do
    case Integer.parse(string) do
      {_, _} -> true
      :error -> false
    end
  end
end
