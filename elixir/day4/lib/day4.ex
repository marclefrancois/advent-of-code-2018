defmodule Day4 do
  def solve do
    input = prepare_input()

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Part one answer:")

    input
    |> Day4.Part1.solve()
    |> IO.inspect()

    time_part_one = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part one took #{time_part_one} milliseconds")

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Part two answer:")

    input
    |> Day4.Part2.solve()
    |> IO.puts()

    time_part_two = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part two took #{time_part_two} milliseconds")

    IO.puts("Total run time #{time_part_one + time_part_two} milliseconds")
  end

  defp prepare_input do
    "../../inputFiles/day4/input.txt"
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
  end

  def parse_inputs(input) do
    input
    |> Enum.sort()
    |> Enum.map(fn x ->
      [time, action] =
        x
        |> String.trim_leading("[")
        |> String.split("] ")

      %{time: time, action: action}
    end)
    |> Enum.reduce(%{}, fn x, acc ->
      [first, second | _] = String.split(x[:action], " ")

      updated =
        case first do
          "Guard" ->
            guard_id =
              second
              |> String.trim_leading("#")
              |> String.to_integer()

            acc
            |> Map.put_new(guard_id, [])
            |> Map.put(:current_guard, guard_id)

          # Start counting minutes
          "falls" ->
            start_minute =
              x[:time]
              |> String.split(":")
              |> List.last()
              |> String.to_integer()

            acc
            |> Map.put(:current_start, start_minute)

          # Stop counting minutes
          "wakes" ->
            start_minute = acc[:current_start]

            end_minute =
              x[:time]
              |> String.split(":")
              |> List.last()
              |> String.to_integer()

            minutes = Enum.reduce(start_minute..(end_minute - 1), [], fn x, acc -> [x | acc] end)

            current_list = Map.get(acc, acc[:current_guard])
            Map.put(acc, acc[:current_guard], List.flatten([minutes | current_list]))
        end

      updated
    end)
    |> Enum.filter(fn {key, _} ->
      case key do
        :current_guard -> false
        :current_start -> false
        _ -> true
      end
    end)
  end

  def choose_guard(input, pick_best) do
    input
    |> Enum.reduce(%{chosen_guard: nil}, fn x, acc ->
      case acc[:chosen_guard] do
        nil -> Map.put(acc, :chosen_guard, x)
        _ -> Map.put(acc, :chosen_guard, pick_best.(acc, x))
      end
    end)
    |> Enum.reduce(0, fn x, _ ->
      {:chosen_guard, value} = x
      {guard_id, minutes} = value

      best_minutes = best_minutes(minutes)

      {minute, _} = best_minutes
      guard_id * minute
    end)
  end

  def best_minutes(minutes) do
    Enum.group_by(minutes, fn x -> x end)
    |> Enum.sort(fn {_, value1}, {_, value2} -> Enum.count(value1) >= Enum.count(value2) end)
    |> List.first()
  end
end

defmodule Day4.Part1 do
  def solve(input) do
    input
    |> Day4.parse_inputs()
    |> Day4.choose_guard(&pick_best/2)
  end

  defp pick_best(previous, current) do
    {_, pvalue} = previous[:chosen_guard]
    {_, value} = current

    if Enum.count(pvalue) > Enum.count(value) do
      previous[:chosen_guard]
    else
      current
    end
  end
end

defmodule Day4.Part2 do
  def solve(input) do
    input
    |> Day4.parse_inputs()
    |> Day4.choose_guard(&pick_best/2)
  end

  defp pick_best(previous, current) do
    {_, pvalue} = previous[:chosen_guard]
    {_, value} = current

    pminutes = case Day4.best_minutes(pvalue) do
      {_, values} -> values
      _ -> []
    end

    minutes = case Day4.best_minutes(value) do
      {_, values} -> values
      _ -> []
    end

    if Enum.count(pminutes) > Enum.count(minutes) do
      previous[:chosen_guard]
    else
      current
    end
  end
end
