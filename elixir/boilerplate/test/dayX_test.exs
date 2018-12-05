defmodule DayXPart1Test do
  use ExUnit.Case
  import DayX.Part1

  test "part 1 solve" do
    result = solve(4)

    assert result == 4
  end
end

defmodule DayXPart2Test do
  use ExUnit.Case
  import DayX.Part2

  test "part 2 solve" do
    result = solve(2)

    assert result == 2
  end
end
