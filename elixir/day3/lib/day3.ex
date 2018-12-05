defmodule Day3 do
  def solve do
    config =
      prepare_input()
      |> Day3.prepare_config()

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Part one answer:")

    matrices =
      config
      |> Day3.build_matrices()

    matrices
    |> Day3.Part1.solve()
    |> IO.puts()

    time_part_one = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part one took #{time_part_one} milliseconds")

    start = System.monotonic_time(unquote(:milli_seconds))
    IO.puts("Part two answer:")

    config
    |> Day3.Part2.solve(matrices)
    |> IO.puts()

    time_part_two = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part two took #{time_part_two} milliseconds")

    IO.puts("Total run time #{time_part_one + time_part_two} milliseconds")
  end

  defp prepare_input do
    "../../inputFiles/day3/input.txt"
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.to_list()
  end

  def prepare_config(input) do
    input
    |> Enum.map(&matrices_config/1)
  end

  defp matrices_config(configuration) do
    split =
      configuration
      |> String.split("@")

    id =
      split
      |> hd
      |> String.trim()
      |> String.split("#")
      |> tl
      |> Enum.join()
      |> String.to_integer()

    split
    |> tl
    |> Enum.join()
    |> String.split(":")
    |> Enum.map(&String.trim/1)
    |> matrice_specs(id)
  end

  defp matrice_specs([pos, size], id) do
    [x, y] =
      String.split(pos, ",")
      |> Enum.map(&String.to_integer/1)

    [width, height] =
      String.split(size, "x")
      |> Enum.map(&String.to_integer/1)

    %{id: id, top: y, left: x, width: width, height: height}
  end

  def build_matrices(input) do
    Enum.reduce(input, %{}, fn config, acc ->
      Enum.reduce(config.left..(config.left + config.width - 1), acc, fn x, acc ->
        Enum.reduce(config.top..(config.top + config.height - 1), acc, fn y, acc ->
          key = {x, y}

          if acc[key], do: Map.put(acc, key, -1), else: Map.put(acc, key, config.id)
        end)
      end)
    end)
  end
end

defmodule Day3.Part1 do
  def solve(input) do
    input
    |> Map.values()
    |> Enum.count(fn x -> x == -1 end)
  end
end

defmodule Day3.Part2 do
  def solve(input, matrices) do
    values =
      matrices
      |> Map.values()
      |> Enum.filter(fn x -> x > 0 end)
      |> Enum.group_by(fn x -> x end)
      |> Enum.sort()

    result =
      input
      |> Enum.filter(fn config ->
        case Enum.find(values, fn {id, _} -> id == config.id end) do
          {_, value} -> Enum.count(value) == config.width * config.height
          _ -> false
        end
      end)

    case Enum.count(result) do
      1 -> hd(result).id
      _ -> :error
    end
  end
end
