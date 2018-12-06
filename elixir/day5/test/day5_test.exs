defmodule Day5Part1Test do
  use ExUnit.Case
  import Day5.Part1

  test "part 1 solve" do
    result = solve("dabAcCaBCBAcCcaDA")

    assert result == "daCBAcaDA"
  end
end

defmodule Day5Part2Test do
  use ExUnit.Case
  import Day5.Part2

  test "part 2 solve" do
    result = solve(2)

    assert result == 2
  end
end
