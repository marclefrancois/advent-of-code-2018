defmodule Day2 do
  def solve do
    input = prepare_input()

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Solving part one:")
    Day2.Part1.solve(input)
    |> IO.puts
    time_part_one = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part one took #{time_part_one} milliseconds")

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Solving part two")
    Day2.Part2.solve(input)
    time_part_two = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part Two took #{time_part_two} milliseconds")
  end

  def prepare_input do
    "../../inputFiles/day2/input.txt"
      |> File.stream!()
      |> Stream.map(&String.trim_trailing/1)
      |> Enum.to_list()
  end
end

defmodule Day2.Part1 do
  def solve(input) do
    %{twos: twos, threes: threes} =
      input
      |> Enum.reduce(%{twos: 0, threes: 0}, &find_repeating_chars/2)

    twos * threes
  end

  defp find_repeating_chars(string, acc) do
    counts =
      string
      |> String.graphemes()
      |> Enum.reduce(%{}, &find_threes_and_twos/2)

    two = if Enum.find_value(Map.values(counts), fn x ->
      x == 2
    end), do: 1, else: 0

    three = if Enum.find_value(Map.values(counts), fn x ->
      x == 3
    end), do: 1, else: 0

    %{twos: twos, threes: threes} = acc
    %{acc | twos: twos + two, threes: threes + three }
  end

  defp find_threes_and_twos(char, acc) do
    case acc do
      %{^char => current_count} -> %{acc | char => current_count + 1}
      _ -> Map.put(acc, char, 1)
    end
  end
end

defmodule Day2.Part2 do
  def solve(input) do
  end
end
