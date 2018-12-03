defmodule Day3Part1Test do
  use ExUnit.Case
  import Day3.Part1

  test "build matrices" do
    matrices =
      ["#1 @ 1,3: 4x4", "#2 @ 5,5: 2x2", "#3 @ 3,1: 4x4"]
      |> Day3.prepare_config()
      |> build_matrices

    assert matrices == [
             [0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 1, 1, 1, 1],
             [0, 0, 0, 1, 1, 1, 1],
             [0, 1, 1, 2, 2, 1, 1],
             [0, 1, 1, 2, 2, 1, 1],
             [0, 1, 1, 1, 1, 1, 1],
             [0, 1, 1, 1, 1, 1, 1]
           ]
  end

  test "part 1 solve" do
    result =
      ["#1 @ 1,3: 4x4", "#2 @ 5,5: 2x2", "#3 @ 3,1: 4x4"]
      |> Day3.prepare_config()
      |> solve

    assert result == 4
  end
end

defmodule Day3Part2Test do
  use ExUnit.Case
  import Day3.Part2

  test "part 1 solve" do
    result =
      ["#1 @ 1,3: 4x4", "#2 @ 5,5: 2x2", "#3 @ 3,1: 4x4"]
      |> Day3.prepare_config()
      |> solve

    assert result == 4
  end
end
