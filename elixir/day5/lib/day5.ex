defmodule Day5 do
  def solve do
    input = prepare_input()

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("---Part one---")
    IO.puts("Answer:")

    input
    |> Day5.Part1.solve()
    |> IO.puts()

    time_part_one = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Took #{time_part_one} milliseconds")
    IO.puts("---------------------------")
    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("---Part two---")
    IO.puts("Answer:")

    input
    |> Day5.Part2.solve()
    |> IO.puts()

    time_part_two = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Took #{time_part_two} milliseconds")
    IO.puts("---------------------------")
    IO.puts("Total run time #{time_part_one + time_part_two} milliseconds")
  end

  defp prepare_input do
    "../../inputFiles/Day5/input.txt"
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
    |> hd
  end
end

defmodule Day5.Part1 do
  def solve(input) do
    input
    |> String.to_charlist
    |> collapse_string(0)
    |> Enum.count()
  end

  defp collapse_string(chars, index) do
    if (index == Enum.count(chars) - 1) do
      chars
    else
      first = Enum.at(chars, index)
      second =Enum.at(chars, index + 1)

      case first != second && abs(first - second) == 32 do
        true ->
          chars
          |> List.delete_at(index + 1)
          |> List.delete_at(index)
          |> collapse_string(if index > 0, do: index - 1, else: index)

        false ->
          collapse_string(chars, index + 1)
      end
    end
  end
end

defmodule Day5.Part2 do
  def solve(input) do
    input
    |> String.length()
  end
end
