defmodule Day3Part1Test do
  use ExUnit.Case
  import Day3.Part1

  test "build bitmap" do
    matrices =
      ["#1 @ 1,3: 4x4", "#2 @ 5,5: 2x2", "#3 @ 2,1: 4x4"]
      |> Day3.prepare_config()
      |> Day3.build_matrices()

    assert matrices == %{
      {2,1} => 3, {3,1} => 3, {4,1} => 3, {5,1} => 3,
      {2,2} => 3, {3,2} => 3, {4,2} => 3, {5,2} => 3,
      {1,3} => 1, {2,3} => -1, {3,3} => -1, {4,3} => -1, {5,3} => 3,
      {1,4} => 1, {2,4} => -1, {3,4} => -1, {4,4} => -1, {5,4} => 3,
      {1,5} => 1, {2,5} => 1, {3,5} => 1, {4,5} => 1, {5,5} => 2, {6,5} => 2,
      {1,6} => 1, {2,6} => 1, {3,6} => 1, {4,6} => 1, {5,6} => 2, {6,6} => 2
    }
  end

  test "part 1 solve" do
    result =
      ["#1 @ 1,3: 4x4", "#2 @ 5,5: 2x2", "#3 @ 3,1: 4x4"]
      |> Day3.prepare_config()
      |> Day3.build_matrices()
      |> solve

    assert result == 4
  end
end

defmodule Day3Part2Test do
  use ExUnit.Case
  import Day3.Part2

  test "part 2 solve" do
    config =
      ["#1 @ 1,3: 4x4", "#2 @ 5,5: 2x2", "#3 @ 3,1: 4x4"]
      |> Day3.prepare_config()

    matrices =
      config
      |> Day3.build_matrices()

    result =
      config
      |> solve(matrices)

    assert result == 2
  end
end
