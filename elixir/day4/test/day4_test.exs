defmodule Day4TestUtils do
  def input do
    Enum.shuffle([
      "[1518-11-01 00:00] Guard #10 begins shift",
      "[1518-11-01 00:05] falls asleep",
      "[1518-11-01 00:25] wakes up",
      "[1518-11-01 00:30] falls asleep",
      "[1518-11-01 00:55] wakes up",
      "[1518-11-01 23:58] Guard #99 begins shift",
      "[1518-11-02 00:40] falls asleep",
      "[1518-11-02 00:50] wakes up",
      "[1518-11-03 00:05] Guard #10 begins shift",
      "[1518-11-03 00:24] falls asleep",
      "[1518-11-03 00:29] wakes up",
      "[1518-11-04 00:02] Guard #99 begins shift",
      "[1518-11-04 00:36] falls asleep",
      "[1518-11-04 00:46] wakes up",
      "[1518-11-05 00:03] Guard #99 begins shift",
      "[1518-11-05 00:45] falls asleep",
      "[1518-11-05 00:55] wakes up"
    ])
  end
end

defmodule Day4Part1Test do
  use ExUnit.Case
  import Day4.Part1

  test "part 1 solve" do
    result =
      Day4TestUtils.input()
      |> solve()

    assert result == 240
  end
end

defmodule Day4Part2Test do
  use ExUnit.Case
  import Day4.Part2

  test "part 2 solve" do
    result =
      Day4TestUtils.input()
      |> solve()

    assert result == 4455
  end
end
