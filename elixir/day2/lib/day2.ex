defmodule Day2 do
  def solve do
    input = prepare_input()

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Solving part one:")

    Day2.Part1.solve(input)
    |> IO.puts()

    time_part_one = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part one took #{time_part_one} milliseconds")

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Solving part two")

    Day2.Part2.solve(input)
    |> IO.puts()

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

    two =
      if Enum.find_value(Map.values(counts), fn x ->
           x == 2
         end),
         do: 1,
         else: 0

    three =
      if Enum.find_value(Map.values(counts), fn x ->
           x == 3
         end),
         do: 1,
         else: 0

    %{twos: twos, threes: threes} = acc
    %{acc | twos: twos + two, threes: threes + three}
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
    input
    |> Enum.map(fn x -> %{string: x, closest: find_closest(x, input)} end)
    |> Enum.reduce(%{distance: 0, sibling: nil, string: nil}, fn x, acc ->
      keep_closest(x, acc)
    end)
    |> common_part
  end

  defp find_closest(string, list) do
    Enum.reduce(list, %{}, fn x, acc ->
      distance = distance_between(string, x)

      if distance > 0 do
        case acc do
          %{distance: current_distance} ->
            if current_distance > distance do
              %{acc | distance: distance, sibling: x}
            else
              acc
            end

          _ ->
            Map.put(acc, :distance, distance)
            |> Map.put(:sibling, x)
        end
      else
        acc
      end
    end)
  end

  defp compare_at_index(char, parent, other_list) do
    index = Enum.find_index(parent, fn x -> x == char end)
    other_char = Enum.at(other_list, index)
    if char == other_char, do: 0, else: 1
  end

  defp keep_closest(candidate, acc) do
    %{closest: %{distance: current_distance, sibling: sibling}, string: string} = candidate
    %{distance: previous_distance} = acc

    if current_distance < previous_distance || previous_distance == 0 do
      %{acc | distance: current_distance, string: string, sibling: sibling}
    else
      acc
    end
  end

  defp common_part(%{distance: _, string: string, sibling: sibling}) do
    temp = String.graphemes(string) -- String.graphemes(sibling)
    final = String.graphemes(string) -- temp

    Enum.join(final)
  end

  defp distance_between(string1, string2) do
    String.graphemes(string1)
    |> Enum.with_index()
    |> Enum.reduce(0, fn {value, index}, acc ->
      acc +
        if value ==
             string2
             |> String.graphemes()
             |> Enum.at(index),
           do: 0,
           else: 1
    end)
  end
end
