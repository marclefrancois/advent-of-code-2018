defmodule DayX do
  def solve do
    input =
      prepare_input()

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Part one answer:")

    input
    |> DayX.Part1.solve()
    |> IO.puts()

    time_part_one = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part one took #{time_part_one} milliseconds")

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Part two answer:")

    input
    |> DayX.Part2.solve()
    |> IO.puts()

    time_part_two = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part two took #{time_part_two} milliseconds")

    IO.puts("Total run time #{time_part_one + time_part_two} milliseconds")
  end

  defp prepare_input do
    "../../inputFiles/DayX/input.txt"
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
  end
end

defmodule DayX.Part1 do
  def solve(input) do
    input
  end
end

defmodule DayX.Part2 do
  def solve(input) do
    input
  end
end
