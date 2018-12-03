defmodule Day3 do
  def solve do
    input = prepare_input()

    start = System.monotonic_time(unquote(:milli_seconds))

    input
    |> Day3.Part1.solve()
    |> IO.puts()

    time_part_one = System.monotonic_time(unquote(:milli_seconds)) - start
    IO.puts("Part one took #{time_part_one} milliseconds")
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
    configuration
    |> String.split("@")
    |> tl
    |> Enum.join()
    |> String.split(":")
    |> Enum.map(&String.trim/1)
    |> matrice_specs()
  end

  defp matrice_specs([pos, size]) do
    [x, y] =
      String.split(pos, ",")
      |> Enum.map(&String.to_integer/1)

    [width, height] =
      String.split(size, "x")
      |> Enum.map(&String.to_integer/1)

    %{top: y, left: x, width: width, height: height}
  end
end

defmodule Day3.Part1 do
  def solve(input) do
    input
    |> build_matrices
    |> Enum.flat_map(fn x -> x end)
    |> Enum.count(fn x -> x > 1 end)
  end

  def build_matrices(input) do
    config = input
    largest = find_largest_size(config)

    Enum.reduce(config, Matrix.new(largest[:width], largest[:height]), fn x, acc ->
      Matrix.add(acc, build_matrice(x, largest))
    end)
  end

  defp find_largest_size(config) do
    config
    |> Enum.reduce(%{width: 0, height: 0}, fn x, %{width: w, height: h} ->
      %{width: max(w, x.left + x.width), height: max(h, x.top + x.height)}
    end)
  end

  def build_matrice(config, %{
        width: total_width,
        height: total_height
      }) do
    Matrix.new(total_width, total_height)
    |> Enum.with_index()
    |> Enum.map(fn x -> convert_row(x, config) end)
  end

  defp convert_row({row, index}, %{top: top, left: left, width: width, height: height}) do
    case index do
      n when n < top -> row
      n when n >= top + height -> row
      _ -> adjust_columns(row, left, width)
    end
  end

  defp adjust_columns(row, left, width) do
    row
    |> Enum.with_index()
    |> Enum.map(fn {_, index} ->
      if index >= left && index < left + width, do: 1, else: 0
    end)
  end
end

defmodule Day3.Part2 do
  def solve(_) do
    4
  end
end
